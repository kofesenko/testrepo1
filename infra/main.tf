terraform {
  backend "s3" {
    bucket         = "my-tf-state-bucket-rndcharskf"
    key            = "Development/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
    profile        = "terraform_admin"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Setup AWS provider
provider "aws" {
  region  = var.aws_region
  profile = "terraform_admin"
}