name_prefix        = "static-assets-dev"
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
availability_zone  = "us-east-1a"

ec2_ami_id = "ami-051b98ceceb268091" # AMI ECS Optimized com Docker (Amazon Linux 2023)

ec2_instance_type = "t3.micro"

# vou deixar liberado para acesso ssh de qualquer lugar
ec2_allowed_ssh_cidr_blocks = ["0.0.0.0/0"]

ec2_user_data = ""

# Configuração de chave SSH
ec2_create_key_pair = false
ec2_public_key      = "" #gerenciado pelo .tfvars.local

# Configuração ECR
ec2_ecr_repository = "admin-panel"
ec2_aws_region     = "us-east-1"
ec2_ecr_image_tag  = "latest"
