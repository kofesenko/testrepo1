variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "availability_zone" {
  type        = list(string)
  description = "Availability Zone used by subnet"
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "default_route" {
  type        = string
  description = "Default Route from and to internet"
  default     = "0.0.0.0/0"
}

variable "inbound_ports" {
  type        = list(string)
  description = "List of the inbound ports for Security Group"
  default     = ["22", "80"]
}

variable "ACCOUNT_ID" {
  default = 120029444489
}

variable "container_port" {
  description = "python app container port"
  default     = 5000
}

variable "environment_name" {
  type        = string
  description = "Set environment name"
  default     = "Staging"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.1.0.0/16"
}

variable "public_subnet" {
  type        = list(string)
  description = "Public Subnet"
  default     = ["10.1.0.0/24"]
}

variable "private_subnet" {
  type        = list(string)
  description = "Private Subnet"
  default     = ["10.1.12.0/24"]
}

variable "container_name" {
  default = "python-app"
}