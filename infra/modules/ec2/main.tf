# Security Group para EC2
resource "aws_security_group" "ec2_admin" {
  name        = "${var.name_prefix}-ec2-admin-sg"
  description = "Security Group para EC2 Admin Panel"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr_blocks
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-ec2-admin-sg"
    }
  )
}

resource "aws_iam_role" "ec2_s3_role" {
  name = "${var.name_prefix}-ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "ec2_s3_policy" {
  name = "${var.name_prefix}-ec2-s3-policy"
  role = aws_iam_role.ec2_s3_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Resource = "${var.s3_bucket_arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_ecr_policy" {
  name = "${var.name_prefix}-ec2-ecr-policy"
  role = aws_iam_role.ec2_s3_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:DescribeRepositories",
          "ecr:DescribeImages"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_policy" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "${var.name_prefix}-ec2-s3-profile"
  role = aws_iam_role.ec2_s3_role.name

  tags = var.tags
}

resource "aws_key_pair" "ec2_key" {
  count      = var.create_key_pair ? 1 : 0
  key_name   = "${var.name_prefix}-ec2-key"
  public_key = var.public_key

  tags = var.tags
}

locals {
  user_data_script = var.ecr_repository != "" ? templatefile("${path.module}/user_data.sh", {
    ecr_registry   = var.ecr_registry
    ecr_repository = var.ecr_repository
    image_tag      = var.ecr_image_tag
    aws_region     = var.aws_region
  }) : var.user_data
}

# EC2 Instance
resource "aws_instance" "admin_panel" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_admin.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_s3_profile.name
  key_name               = var.key_name != "" ? var.key_name : (var.create_key_pair ? aws_key_pair.ec2_key[0].key_name : "")

  user_data = base64encode(local.user_data_script)

  tags = merge(
    var.tags,
    {
      Name            = "${var.name_prefix}-admin-panel"
      DeployTarget    = "true"
      ManagedBy       = "terraform"
      Application     = "admin-panel"
    }
  )
}
