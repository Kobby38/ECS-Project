resource "aws_ecs_cluster" "E-Learning-Cluster" {
  name                     = var.ecs_cluster_name
}
 /* setting {
  name  = "containerinsights" 
  value = "enabled"
 }  */

#Task Definitions
resource "aws_ecs_task_definition" "definetaskforcontainer" {
  family                   = "ecs-e-learning-task"
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.ecs_tasks_role.arn
  execution_role_arn       = aws_iam_role.ecs_tasks_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "elearningapp",
    "image": "894113657650.dkr.ecr.eu-west-2.amazonaws.com/elearningapp",
    "cpu": 1024,
    "memory": 2048,
    "portMappings":[
        {
          "containerPort":80,
          "hostPort":80,
          "protocol":"tcp",
          "appProtocol":"http"
        }
    ],
    "essential":true
  }
 ]

TASK_DEFINITION

  runtime_platform {
    operating_system_family         = "LINUX"
    cpu_architecture                = "X86_64"
  }
}

#Creating ECS Service to Run Tasks
resource "aws_ecs_service" "nginxservice" {
 name                               = "nginxservice"
 cluster                            = aws_ecs_cluster.E-Learning-Cluster.id
 task_definition                    = aws_ecs_task_definition.definetaskforcontainer.arn
 desired_count                      = 2
 deployment_minimum_healthy_percent = 100
 deployment_maximum_percent         = 200
 launch_type = "FARGATE"
 platform_version = "LATEST"
 scheduling_strategy = "REPLICA"

  #configure network
  network_configuration {
   security_groups                  = [aws_security_group.ecs_task.id]
   subnets                          = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
   assign_public_ip                 = false
  }

#load balancer
 load_balancer {
   target_group_arn                 = aws_alb_target_group.ip_target.arn
   container_name                   = "elearningapp"
   container_port                   = 80
 }
 #lifecycle
 lifecycle {
   ignore_changes                   = [task_definition, desired_count]
 }
}
#Autoscaling for the Service
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity                      = 4
  min_capacity                      = 2
  resource_id                       = "service/${aws_ecs_cluster.E-Learning-Cluster.name}/${aws_ecs_service.nginxservice.name}"
  scalable_dimension                = "ecs:service:DesiredCount"
  service_namespace                 = "ecs"
}

#Auotscaling policy
resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  name                              = "cpu-autoscaling"
  policy_type                       = "TargetTrackingScaling"
  resource_id                       = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension                = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace                 = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type        = "ECSServiceAverageCPUUtilization"
    }
    target_value                    = 70
  }
}

