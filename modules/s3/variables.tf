variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the bucket"
  default     = {}
}

variable "create_cloudfront_policy" {
  type        = bool
  description = "Whether to create a bucket policy for CloudFront OAC access"
  default     = false
}

variable "cloudfront_distribution_arn" {
  type        = string
  description = "ARN da distribuição CloudFront (required if create_cloudfront_policy is true)"
  default     = null
}

variable "bucket_policy_actions" {
  type        = list(string)
  description = "Actions to allow in the bucket policy for CloudFront"
  default     = ["s3:GetObject"]
}

variable "policy_statement_sid" {
  type        = string
  description = "SID (Statement ID) para a política do bucket"
  default     = "AllowCloudFrontServicePrincipalReadWrite"
}