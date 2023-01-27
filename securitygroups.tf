# configuring internet-facing load balancer security group 
resource "aws_security_group" "alb-sg"{
  name              = "production-alb"
  description       = "Allow HTTP and HTTPS"
  vpc_id            = aws_vpc.ecs_vpc.id

  #Inbound Rules
  ingress {
    description     = "HTTP from VPC"
    from_port       = var.alb_http_ingress_port
    to_port         = var.alb_http_ingress_port
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    description     = "HTTPS from VPC"
    from_port       = var.alb_https_ingress_port
    to_port         = var.alb_https_ingress_port
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
   }
  
  #Outbound Rules  
  egress {
    description     = "Allow all IP and ports outbound"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.envrionment_name
  }
}
# Security group for ECS Contaianers (traffic ALB -> ECS)
resource "aws_security_group" "ecs_task" {
  name              = "ecs_security_group"
  description       = "Allows inbound access from the ALB only"
  vpc_id            = aws_vpc.ecs_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
 
# RDS Security Group (Allow inbound traffic from ECS only)
resource "aws_security_group" "rds" {
  name              = "rds-security-group"
  description       = "Allows inbound access from ECS only"
  vpc_id            = aws_vpc.ecs_vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = "5432"
    to_port         = "5432"
    security_groups = [aws_security_group.ecs_task.id]
  }

  egress {
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    cidr_blocks     = ["0.0.0.0/0"]
  }
}