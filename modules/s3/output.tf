output "bucket_id" {
  description = "ID do bucket S3"
  value       = aws_s3_bucket.bucket_frontend.id
}

output "bucket_domain_name" {
  description = "Domain name do bucket S3 (para CloudFront)"
  value       = aws_s3_bucket.bucket_frontend.bucket_regional_domain_name
}

output "bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.bucket_frontend.arn
}

output "bucket_policy_id" {
  description = "ID da política do bucket (se criada)"
  value       = var.create_cloudfront_policy ? try(aws_s3_bucket_policy.bucket_policy["policy"].id, null) : null
}