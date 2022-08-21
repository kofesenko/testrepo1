# Configuration related to security groups
# Staging
resource "aws_security_group" "staging_public" {
  name        = "staging-public"
  description = "Security Group for public staging"
  vpc_id      = module.vpc_staging.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.default_route]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.default_route]
  }
  #   dynamic "ingress" {
  #     for_each = var.inbound_ports
  #     content {
  #         from_port   = ingress.value
  #         to_port     = ingress.value
  #         protocol    = "tcp"
  #         cidr_blocks = [var.default_route]
  #     }
  #   }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }

  tags = {
    Name = "staging-public"
  }
}

resource "aws_security_group" "staging_private" {
  name        = "staging-private"
  description = "Security Group for private staging"
  vpc_id      = module.vpc_staging.vpc_id

  ingress {
    description     = "from staging-public"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_public.id]
  }

  ingress {
    description     = "from staging-public"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_public.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }

  tags = {
    Name = "staging-private"
  }
}
