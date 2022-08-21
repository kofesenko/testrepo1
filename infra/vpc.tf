# Create VPC from module
locals {
  cidr_subnets = cidrsubnet("10.0.0.0/17", 4, 4, 4, 4, 4, 4)
}
module "vpc" {
  source = "../modules/vpc/"

  infrastructure_environment = var.environment_name
  vpc_cidr = "10.0.0.0/17"
  azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnet = slice(local.cidr_subnets, 0, 3)
  private_subnet = slice(local.cidr_subnets, 4, 6)
}
