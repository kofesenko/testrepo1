output "subnet_staging_public_a" {
  value = aws_subnet.public_subnet_az.[*].id
}

output "subnet_staging_private_a" {
  value = aws_subnet.private_subnet_az.[*].id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}