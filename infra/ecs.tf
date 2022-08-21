resource "aws_ecs_cluster" "python_app_cluster" {
  name = "python-app-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
#Service that is running based on the task definition
resource "aws_ecs_service" "python_service" {
  name            = "service-for-python-app"
  cluster         = aws_ecs_cluster.python_app_cluster.id
  task_definition = aws_ecs_task_definition.python_task.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs_service_role.arn
  depends_on      = [aws_iam_role_policy.ecs_policy, aws_ecs_task_definition.python_task]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

resource "aws_ecs_task_definition" "python_task" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = "${var.ACCOUNT_ID}.dkr.ecr.${var.aws_region}.amazonaws.com/${aws_ecr_repository.python_app.name}:latest"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = 0
        }
      ]
    },
  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

}

#Need for autoscaling group
resource "aws_launch_configuration" "ecs_launch_config" {
  name                 = "ecs_cluster"
  image_id             = "ami-044fb3b709f19cb4a"
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  security_groups      = [aws_security_group.staging_private.id]
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.python_app_cluster.name} >> /etc/ecs/ecs.config"
  instance_type        = "t2.micro"
  key_name             = "terraform_admin"

}
#Manage autoscaling group for ecs
resource "aws_autoscaling_group" "ecs_auto_scaling_group" {
  name                 = "asg"
  vpc_zone_identifier  = [module.vpc_staging.subnet_staging_private_a[0], module.vpc_staging.subnet_staging_private_a[1]]
  launch_configuration = aws_launch_configuration.ecs_launch_config.name

  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "EC2"
}