output "cloudfront_domain_name" {
  description = "Domínio da distribuição CloudFront"
  value       = module.cloudfront.distribution_domain_name
}

output "admin_panel_public_ip" {
  description = "IP público do painel administrativo"
  value       = module.ec2_admin.instance_public_ip
}
