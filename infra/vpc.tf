module "vpc_staging" {
  source = "../modules/vpc/"

  environment_name         = "Staging"
  vpc_cidr                 = "10.1.0.0/16"
  public_subnet_cidr_az  = ["10.1.0.0/24"]
  private_subnet_cidr_az = ["10.1.12.0/24"]

  additional_tags = {
    Environment = "Staging"
    Owner       = "Myself"
  }
}
