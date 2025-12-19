name_prefix        = "static-assets-dev"
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
availability_zone  = "us-east-1a"

ec2_ami_id = "ami-051b98ceceb268091" # AMI ECS Optimized com Docker (Amazon Linux 2023)

ec2_instance_type = "t3.micro"

# vou deixar liberado para acesso ssh de qualquer lugar
ec2_allowed_ssh_cidr_blocks = ["0.0.0.0/0"]

ec2_user_data = ""

# Configuração de chave SSH
ec2_create_key_pair = true
ec2_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDA5opbEZy3UbQO51hTGnZEiyGW9VC29utCrsReErjTY+AU9KbkK1UUr64fyN1nCGzRmUTMweC81Wfmbd8K7NO4ou7royPIsNyLOSVd1u5WfulWKLBQ4gbbBRkrPOKeQtRLwxvJV1qf7zFx+aoSZK6chZkNaaPRBP+ocuMxvarwLZ/PZ6OKRGYsECx/+ubqP08wYoaO+8NWG8jBMLGOJXvNB+IR3ZO9ZhcXkaCnpYgbYkB0fy5qeOKrDON/KisJqmovKF5hvq2ALS9oluTBUSwUK9BZOpWIQTIWOYUQdFWuY/ASg5TCOyRo6RevgwWAe6KwBr1thkZhOxmFpA05PbwgdRaZF5QMMfj9MN6l7kwrEzXFx8alHw3KJwz3lz2ERZAK9tHztPPNBP+lHVAetmMcFqNTPSA2G/tSlA9gF/jB+Dgq8XDsYoCI1Sb6CFWi+BtP9kcCnRaLjXaTsGMKBFRXff2lnWTuGwEMoRRDFE/Brm6bGd3+2FXN1WGOBrI1YkFxND7jDzt7NnFJo4KiXRA1llDP8QRH4heLxQcQhrOPCQrR+lc9m6gJtjZhgH9+LGvyiWz3khk56gvcxyHXhXPQ0kp8IsGsbj3FqvwvA7ugx9sIvEjG06goJQuLA3vOwQLL+GtcrUdvhVXlnGadtNKIG6aJj1cAgLpiJ9xIsAHC0Q== ec2-admin-panel"
