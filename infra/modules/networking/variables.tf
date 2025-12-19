variable "name_prefix" {
  type        = string
  description = "Prefix para nomes dos recursos"
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
}

variable "tags" {
  type        = map(string)
  description = "Tags para aplicar aos recursos"
  default     = {}
}

