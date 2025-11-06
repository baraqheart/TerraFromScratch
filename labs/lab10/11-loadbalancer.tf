resource "aws_lb" "frontend" {
  name               = "${local.project}-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_security_group.id]
  subnets            = [aws_subnet.public_zone1.id, aws_subnet.public_zone2.id]

  enable_deletion_protection = false

  tags = {
    Name        = "${local.project}-loadbalancer"
    Environment = local.environment
  }
}



//Target group to send requests to

resource "aws_lb_target_group" "frontend" {
  name                          = "frontend-tg"
  port                          = 80
  protocol                      = "HTTP"
  target_type                   = "ip"
  vpc_id                        = aws_vpc.main.id
  load_balancing_algorithm_type = "least_outstanding_requests" # round_robin | least_outstanding_requests | weighted_random


  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
  tags = {
    Name = "${local.project}-target-group"
  }
}

