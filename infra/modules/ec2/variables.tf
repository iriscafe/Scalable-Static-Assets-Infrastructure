variable "name_prefix" {
  type        = string
  description = "Prefix para nomes dos recursos"
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC onde a EC2 será criada"
}

variable "subnet_id" {
  type        = string
  description = "ID da subnet pública onde a EC2 será criada"
}

variable "s3_bucket_arn" {
  type        = string
  description = "ARN do bucket S3 para conceder permissões"
}

variable "ami_id" {
  type        = string
  description = "AMI ID para a instância EC2"
}

variable "instance_type" {
  type        = string
  description = "Tipo de instância EC2"
  default     = "t3.micro"
}

variable "allowed_ssh_cidr_blocks" {
  type        = list(string)
  description = "Lista de blocos CIDR permitidos para acesso SSH"
  default     = ["0.0.0.0/0"]
}

variable "user_data" {
  type        = string
  description = "Script user_data para a instância EC2"
  default     = ""
}

variable "key_name" {
  type        = string
  description = "Nome da chave SSH existente (deixe vazio para criar nova ou não usar)"
  default     = ""
}

variable "create_key_pair" {
  type        = bool
  description = "Se true, cria um novo Key Pair"
  default     = false
}

variable "public_key" {
  type        = string
  description = "Chave pública SSH (necessário se create_key_pair = true)"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags para aplicar aos recursos"
  default     = {}
}

variable "ecr_repository" {
  type        = string
  description = "Nome do repositório ECR"
  default     = ""
}

variable "aws_region" {
  type        = string
  description = "Região AWS"
  default     = "us-east-1"
}

variable "ecr_image_tag" {
  type        = string
  description = "Tag da imagem Docker no ECR"
  default     = "latest"
}

variable "ecr_registry" {
  type        = string
  description = "Registry do ECR (formato: ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com)"
  default     = ""
}

