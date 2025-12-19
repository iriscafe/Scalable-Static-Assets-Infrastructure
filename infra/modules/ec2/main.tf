# Security Group para EC2
resource "aws_security_group" "ec2_admin" {
  name        = "${var.name_prefix}-ec2-admin-sg"
  description = "Security Group para EC2 Admin Panel"
  vpc_id      = var.vpc_id

  # SSH - restrito por IP se especificado
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr_blocks
  }

  # HTTP
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

  # Porta 8080 para aplicações Docker
  ingress {
    description = "HTTP 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress - permitir todo tráfego de saída
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

# IAM Role para EC2 com permissões S3
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

# Política IAM para acesso ao S3 (menor privilégio - apenas PutObject)
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

# Instance Profile para associar o IAM Role à EC2
resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "${var.name_prefix}-ec2-s3-profile"
  role = aws_iam_role.ec2_s3_role.name

  tags = var.tags
}

# Key Pair para acesso SSH
resource "aws_key_pair" "ec2_key" {
  count      = var.create_key_pair ? 1 : 0
  key_name   = "${var.name_prefix}-ec2-key"
  public_key = var.public_key

  tags = var.tags
}

# EC2 Instance
resource "aws_instance" "admin_panel" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_admin.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_s3_profile.name
  key_name               = var.key_name != "" ? var.key_name : (var.create_key_pair ? aws_key_pair.ec2_key[0].key_name : "")

  user_data = var.user_data

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-admin-panel"
    }
  )
}
