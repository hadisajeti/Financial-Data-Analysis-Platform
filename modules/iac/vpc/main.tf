resource "aws_vpc" "my_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc-financial"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id               = aws_vpc.my_vpc.id
  cidr_block           = var.public_subnet_cidr
  availability_zone    = "${"eu-central-1"}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id               = aws_vpc.my_vpc.id
  cidr_block           = var.private_subnet_cidr
  availability_zone    = "${"eu-central-1"}b"

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id               = aws_vpc.my_vpc.id
  cidr_block           = var.private_subnet_cidr_c
  availability_zone    = "${"eu-central-1"}c"

  tags = {
    Name = "private-subnet-c"
  }
}


resource "aws_network_acl" "my_nacl" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_network_acl_rule" "allow_outbound" {
  network_acl_id = aws_network_acl.my_nacl.id
  rule_number    = 100
  protocol       = -1
  rule_action    = "allow"
  egress         = true
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "allow_inbound" {
  network_acl_id = aws_network_acl.my_nacl.id
  rule_number    = 200
  protocol       = -1
  rule_action    = "allow"
  egress         = false
  cidr_block     = "10.0.0.0/16"
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}
