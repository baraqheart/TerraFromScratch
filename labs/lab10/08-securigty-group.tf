
// security group for load balancer - internet facing
resource "aws_security_group" "lb_security_group" {
  name        = "lb_security_group"
  description = "Allow inbound traffic and all outbound traffic from internet"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${local.project}-loadbalancer-ecs-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http_lb" {
  security_group_id = aws_security_group.lb_security_group.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_ingress_rule" "https_lb" {
  security_group_id = aws_security_group.lb_security_group.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "outboud_ipv4_lb" {
  security_group_id = aws_security_group.lb_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "outboud_ipv6_lb" {
  security_group_id = aws_security_group.lb_security_group.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}

// security group for ecs
resource "aws_security_group" "ecs_security_group" {
  name        = "ecs_security_group"
  description = "Allow inbound traffic from ALB and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${local.project}-ecs-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "container_port" {
  security_group_id            = aws_security_group.ecs_security_group.id
  referenced_security_group_id = aws_security_group.lb_security_group.id

  from_port   = var.container_port
  ip_protocol = "tcp"
  to_port     = var.container_port
}




resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ecs_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.ecs_security_group.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}
