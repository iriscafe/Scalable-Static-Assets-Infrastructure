output "instance_id" {
  description = "ID da instância EC2"
  value       = aws_instance.admin_panel.id
}

output "instance_public_ip" {
  description = "IP público da instância EC2"
  value       = aws_instance.admin_panel.public_ip
}

output "instance_private_ip" {
  description = "IP privado da instância EC2"
  value       = aws_instance.admin_panel.private_ip
}

output "security_group_id" {
  description = "ID do Security Group da EC2"
  value       = aws_security_group.ec2_admin.id
}

output "iam_role_arn" {
  description = "ARN do IAM Role associado à EC2"
  value       = aws_iam_role.ec2_s3_role.arn
}

output "key_pair_name" {
  description = "Nome do Key Pair criado (se create_key_pair = true)"
  value       = var.create_key_pair ? aws_key_pair.ec2_key[0].key_name : null
}

