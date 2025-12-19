terraform {
  backend "s3" {
    bucket         = "backend-front-tf-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    profile        = "personal"
  }
}

