resource "aws_lb" "frontend" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = [aws_subnet.public_zone1.id, aws_subnet.public_zone2.id]

  enable_deletion_protection = false

  tags = {
    Name        = "${local.project}-lb"
    Environment = local.environment
  }
}



//Target group to send requests to

resource "aws_lb_target_group" "frontend" {
  name                          = "frontend-tg"
  port                          = 80
  protocol                      = "HTTP"
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

resource "aws_lb_target_group_attachment" "web1" {
  target_group_arn = aws_lb_target_group.frontend.arn
  target_id        = aws_instance.web1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web2" {
  target_group_arn = aws_lb_target_group.frontend.arn
  target_id        = aws_instance.web2.id
  port             = 80
}


/*
resource "aws_lb_target_group_attachment" "web_instances" {
  for_each = { for idx, instance in aws_instance.web : idx => instance }
  
  target_group_arn = aws_lb_target_group.frontend.arn
  target_id        = each.value.id
  port             = 8080
}

*/
