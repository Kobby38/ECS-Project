# Application Load Balancer
resource "aws_lb" "application_alb" {
  name               = var.publicalbname
  load_balancer_type = var.loadbalancertype
  internal           = var.internal
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = [aws_subnet.public_subnet-1.id, aws_subnet.public_subnet-2.id]
  enable_deletion_protection = var.enabledeletionprotection

}

# creating Listener for http (redirects traffic from the load balancer to the target group)
resource "aws_alb_listener" "ecs-alb-http-listener" {
  load_balancer_arn  = aws_lb.application_alb.id
  port               = var.listener_port
  protocol           = var.protocol
  depends_on         = [aws_alb_target_group.ip_target]

  default_action {
    type             = "redirect"
    redirect {
    port             = 443
    protocol         = "HTTPS"
    status_code      = "HTTP_301"
  }
}
}

# Creating load balancer listener for https
resource "aws_alb_listener" "ecs-alb-https-listener" {
  load_balancer_arn  = aws_lb.application_alb.id
  port               = "443"
  protocol           = "HTTPS"
  ssl_policy         = "ELBSecurityPolicy-2016-08"
  certificate_arn    = aws_acm_certificate.e-learning.arn
  depends_on         = [aws_alb_target_group.ip_target]

 default_action {
  type = "forward"
  target_group_arn   = aws_alb_target_group.ip_target.arn
 }
}
# Creating Target group
resource "aws_alb_target_group" "ip_target"{
  health_check {
    enabled            = var.enablehealthcheck
    interval            = var.healthcheckinterval
    path                = "/"
    protocol            = var.protocol
    port                = var.healthcheckport
    timeout             = var.healthchecktimeout
    healthy_threshold   = var.healthythreshold
    unhealthy_threshold = var.unhealthythreshold
    matcher             = var.healthcheckmatcher
  }
  name        = var.healthcheckname
  target_type = var.target-type
  port        = var.traffic-port
  protocol    = var.protocol
  vpc_id      = aws_vpc.ecs_vpc.id

  tags = {
    Name = "e-learning-alb-${terraform.workspace}"
  }
}



  
  
  
  
  