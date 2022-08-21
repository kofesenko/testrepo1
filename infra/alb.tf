resource "aws_lb" "loadbalancer" {
  name               = "python-app-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.staging_public.id]
  subnets            = [module.vpc_staging.subnet_staging_public_a[0].id, module.vpc_staging.subnet_staging_public_a[1].id]

  enable_deletion_protection = false

  tags = {
    Environment = var.environment_name
  }
}

resource "aws_lb_target_group" "lb_target" {
  name     = "tf-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc_staging.vpc_id
  depends_on = [
    aws_lb.loadbalancer
  ]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target.arn
  }
}
