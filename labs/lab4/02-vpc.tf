
// Create a VPC
resource "aws_vpc" "main" {
  region               = local.region
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${local.project}-vpc"
  }
}

// Create Public Subnets
resource "aws_subnet" "public_zone1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr[0]
  availability_zone       = "${local.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.project}-public-zone1"
  }
}

resource "aws_subnet" "public_zone2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr[1]
  availability_zone       = "${local.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.project}-public-zone2"
  }
}


//Create private subnets

resource "aws_subnet" "private_zone1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr[0]
  availability_zone = "${local.region}a"


  tags = {
    Name = "${local.project}-private-zone1"
  }
}

resource "aws_subnet" "private_zone2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr[1]
  availability_zone = "${local.region}b"


  tags = {
    Name = "${local.project}-private-zone2"
  }
}

