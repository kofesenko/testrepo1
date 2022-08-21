output "subnet_staging_public_a_0" {
  value = module.vpc_staging.subnet_staging_public_a[0]
  value = module.vpc_staging.subnet_staging_public_a[1]
}

output "subnet_staging_private_a_0" {
  value = module.vpc_staging.subnet_staging_private_a[0]
  value = module.vpc_staging.subnet_staging_private_a[1]
}

output "security_group_staging_public" {
  value = aws_security_group.staging_public.id
}

output "security_group_staging_private" {
  value = aws_security_group.staging_private.id
}

output "load_balancer" {
  value = aws_lb.loadbalancer.dns_name
}