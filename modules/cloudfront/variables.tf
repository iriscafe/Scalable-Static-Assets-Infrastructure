variable "bucket_domain_name" {
  type        = string
  description = "Domain name do bucket S3 (bucket_regional_domain_name)"
}

variable "bucket_id" {
  type        = string
  description = "ID do bucket S3"
}

variable "enabled" {
  type        = bool
  description = "Whether the CloudFront distribution is enabled"
  default     = true
}

variable "is_ipv6_enabled" {
  type        = bool
  description = "Whether IPv6 is enabled"
  default     = true
}

variable "default_root_object" {
  type        = string
  description = "Default root object"
  default     = "index.html"
}

variable "allowed_methods" {
  type        = list(string)
  description = "Allowed HTTP methods for default cache behavior"
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods" {
  type        = list(string)
  description = "Cached HTTP methods for default cache behavior"
  default     = ["GET", "HEAD"]
}

variable "viewer_protocol_policy" {
  type        = string
  description = "Viewer protocol policy (allow-all, https-only, redirect-to-https)"
  default     = "redirect-to-https"
}

variable "min_ttl" {
  type        = number
  description = "Minimum TTL"
  default     = 0
}

variable "default_ttl" {
  type        = number
  description = "Default TTL"
  default     = 3600
}

variable "max_ttl" {
  type        = number
  description = "Maximum TTL"
  default     = 86400
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the CloudFront distribution"
  default     = {}
}
