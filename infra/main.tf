module "s3_buckets" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  tags        = var.tags
  force_destroy = var.force_destroy
  versioning_enabled = var.versioning_enabled
  provision_initial_content = var.provision_initial_content

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

module "networking" {
  source = "./modules/networking"

  name_prefix        = var.name_prefix
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
  tags               = var.tags
}

module "ec2_admin" {
  source = "./modules/ec2"

  name_prefix             = var.name_prefix
  vpc_id                  = module.networking.vpc_id
  subnet_id               = module.networking.public_subnet_id
  s3_bucket_arn           = module.s3_buckets.bucket_arn
  ami_id                  = var.ec2_ami_id
  instance_type           = var.ec2_instance_type
  allowed_ssh_cidr_blocks = var.ec2_allowed_ssh_cidr_blocks
  user_data               = var.ec2_user_data
  key_name                = var.ec2_key_name
  create_key_pair         = var.ec2_create_key_pair
  public_key              = var.ec2_public_key
  tags                    = var.tags
}