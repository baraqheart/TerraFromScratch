// security group for web tier
resource "aws_security_group" "web" {
  name        = "allow_tls_web"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${local.project}-web-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.web.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}



// security group for app tier
resource "aws_security_group" "app" {
  name        = "allow_tls_app"
  description = "Allow all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${local.project}-app-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http_app" {
  security_group_id = aws_security_group.app.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "ssh_app" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.web.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22


}

resource "aws_vpc_security_group_ingress_rule" "https_app" {
  security_group_id = aws_security_group.app.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

/**
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.app.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.app.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" 
}
**/

// security group for load balancer 
resource "aws_security_group" "lb" {
  name        = "allow_tls_lb"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${local.project}-loadbalancer-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http_lb" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_ingress_rule" "https_lb" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "outboud_ipv4_lb" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "outboud_ipv6_lb" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}

