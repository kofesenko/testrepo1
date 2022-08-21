output "subnet_staging_public_a" {
  value = tolist("${aws_subnet.public_subnet_az_a.*.id}")
}

output "subnet_staging_private_a" {
  value = tolist("${aws_subnet.private_subnet_az_a.*.id}")
}

output "subnet_production_public_a" {
  value = tolist("${aws_subnet.public_subnet_az_a.*.id}")
}

output "subnet_production_private_a" {
  value = tolist("${aws_subnet.private_subnet_az_a.*.id}")
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}