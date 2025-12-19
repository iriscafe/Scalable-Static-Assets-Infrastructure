# Variáveis S3
variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the bucket"
  default     = {}
}

variable "force_destroy" {
  type        = bool
  description = "Whether to force destroy the bucket"
  default     = false
}

variable "versioning_enabled" {
  type        = string
  description = "Whether to enable versioning for the bucket, options: Enabled, Disabled"
  default     = "Disabled"
}

variable "provision_initial_content" {
  type        = bool
  description = "Se true, faz upload de um index.html inicial no bucket S3"
  default     = true
}

# Variáveis CloudFront
variable "cloudfront_enabled" {
  type        = bool
  description = "Whether the CloudFront distribution is enabled"
  default     = true
}

variable "cloudfront_is_ipv6_enabled" {
  type        = bool
  description = "Whether IPv6 is enabled for CloudFront"
  default     = true
}

variable "cloudfront_default_root_object" {
  type        = string
  description = "Default root object for CloudFront"
  default     = "index.html"
}

variable "cloudfront_allowed_methods" {
  type        = list(string)
  description = "Allowed HTTP methods for CloudFront"
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cloudfront_cached_methods" {
  type        = list(string)
  description = "Cached HTTP methods for CloudFront"
  default     = ["GET", "HEAD"]
}

variable "cloudfront_viewer_protocol_policy" {
  type        = string
  description = "Viewer protocol policy (allow-all, https-only, redirect-to-https)"
  default     = "redirect-to-https"
}

variable "cloudfront_min_ttl" {
  type        = number
  description = "Minimum TTL for CloudFront cache"
  default     = 0
}

variable "cloudfront_default_ttl" {
  type        = number
  description = "Default TTL for CloudFront cache"
  default     = 3600
}

variable "cloudfront_max_ttl" {
  type        = number
  description = "Maximum TTL for CloudFront cache"
  default     = 86400
}

# Variáveis Networking
variable "name_prefix" {
  type        = string
  description = "Prefix para nomes dos recursos"
  default     = "static-assets"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block para a VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block para a subnet pública"
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone para a subnet"
  default     = "us-east-1a"
}

# Variáveis EC2
variable "ec2_ami_id" {
  type        = string
  description = "AMI ID para a instância EC2"
}

variable "ec2_instance_type" {
  type        = string
  description = "Tipo de instância EC2"
  default     = "t3.micro"
}

variable "ec2_allowed_ssh_cidr_blocks" {
  type        = list(string)
  description = "Lista de blocos CIDR permitidos para acesso SSH (recomendado restringir ao seu IP)"
  default     = ["0.0.0.0/0"]
}

variable "ec2_user_data" {
  type        = string
  description = "Script user_data para a instância EC2"
  default     = ""
}

variable "ec2_key_name" {
  type        = string
  description = "Nome da chave SSH existente (deixe vazio para criar nova)"
  default     = ""
}

variable "ec2_create_key_pair" {
  type        = bool
  description = "Se true, cria um novo Key Pair"
  default     = true
}

variable "ec2_public_key" {
  type        = string
  description = "Chave pública SSH (necessário se ec2_create_key_pair = true)"
  default     = ""
}