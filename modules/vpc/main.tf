resource "aws_vpc" 'vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "${var.environment_name}-vpc"
        Environment = var.environment_name
    }
}

resource "aws_subnet" "public" {
    for_each = var.public_subnet_numbers
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(aws_vpc,vpc.cidr_block, 4, each.value)

    tags = {
        Name = "${var.environment_name}-public-subnet"
        Environment = var.environment_name
        Subnet = "${each.key}-${each.value}"
    }
}

resource "aws_subnet" "private" {
    for_each = var.private_subnet_numbers
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(aws_vpc,vpc.cidr_block, 4, each.value)

    tags = {
        Name = "${var.environment_name}-private-subnet"
        Environment = var.environment_name
        Subnet = "${each.key}-${each.value}"
    }
}

