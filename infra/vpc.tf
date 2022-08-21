# Create VPC from module
module "vpc_staging" {
  source = "../modules/vpc/"

  environment_name         = var.environment_name
  vpc_cidr                 = var.vpc_cidr
  public_subnet_cidr_az_a  = var.public_subnet
  private_subnet_cidr_az_a = var.private_subnet

  additional_tags = {
    Environment = "Staging"
    Owner       = "Myself"
  }
}
#another env 