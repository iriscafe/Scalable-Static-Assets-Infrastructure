module "s3_buckets" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  tags        = var.tags

  create_cloudfront_policy   = true
  cloudfront_distribution_arn = module.cloudfront.distribution_arn
}

module "cloudfront" {
  source = "./modules/cloudfront"

  bucket_domain_name     = module.s3_buckets.bucket_domain_name
  bucket_id              = module.s3_buckets.bucket_id
  enabled                = var.cloudfront_enabled
  is_ipv6_enabled        = var.cloudfront_is_ipv6_enabled
  default_root_object    = var.cloudfront_default_root_object
  allowed_methods        = var.cloudfront_allowed_methods
  cached_methods         = var.cloudfront_cached_methods
  viewer_protocol_policy = var.cloudfront_viewer_protocol_policy
  min_ttl                = var.cloudfront_min_ttl
  default_ttl            = var.cloudfront_default_ttl
  max_ttl                = var.cloudfront_max_ttl
  tags                   = var.tags
}