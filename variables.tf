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