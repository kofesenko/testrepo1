variable "environment_name" {
    type = string
    description = "Environment name"
}

variable "azs" {
    type = list(string)
    description = "AZs to create subnets into"
}
variable "vpc_cidr" {
    type = string
    description = "IP range to use in the VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet" {
    type = list(string)
    description = "Subnets to create for public network traffic, one per AZ"
}

variable "private_subnet" {
    type = list(string)
    description = "Subnets to create for private network traffic, one per AZ"
}
