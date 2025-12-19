output "distribution_id" {
  description = "ID da distribuição CloudFront"
  value       = aws_cloudfront_distribution.s3_distribution.id
}

output "distribution_domain_name" {
  description = "Domain name da distribuição CloudFront"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "distribution_arn" {
  description = "ARN da distribuição CloudFront"
  value       = aws_cloudfront_distribution.s3_distribution.arn
}

output "distribution_hosted_zone_id" {
  description = "Hosted Zone ID da distribuição CloudFront"
  value       = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
}

output "origin_access_control_id" {
  description = "ID do Origin Access Control"
  value       = aws_cloudfront_origin_access_control.default.id
}
