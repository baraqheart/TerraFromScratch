data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

// generate key pair for web tier
# RSA key of size 4096 bits best for instances
resource "tls_private_key" "web_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "web_key" {
  content         = tls_private_key.web_key.private_key_openssh
  filename        = "${path.root}/web_key.pem" #use path.module for when using modules
  file_permission = "0400"
}

resource "aws_key_pair" "web_key" {
  key_name   = "${var.key_name}-${local.project}-key"
  public_key = tls_private_key.web_key.public_key_openssh

}

// web instance for public subnets
resource "aws_instance" "web1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_zone1.id
  key_name                    = aws_key_pair.web_key.key_name
  security_groups             = [aws_security_group.web.id]


  tags = {
    Name = "${local.project}-web1-instance"
  }
}


resource "aws_instance" "web2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_zone2.id
  key_name                    = aws_key_pair.web_key.key_name
  security_groups             = [aws_security_group.web.id]


  tags = {
    Name = "${local.project}-web2-instance"
  }
}


// web instance for public subnets
resource "aws_instance" "app1" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  subnet_id       = aws_subnet.private_zone1.id
  key_name        = aws_key_pair.web_key.key_name
  security_groups = [aws_security_group.web.id]


  tags = {
    Name = "${local.project}-app1-instance"
  }
}


resource "aws_instance" "app2" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  subnet_id       = aws_subnet.private_zone2.id
  key_name        = aws_key_pair.web_key.key_name
  security_groups = [aws_security_group.web.id]


  tags = {
    Name = "${local.project}-app2-instance"
  }
}
