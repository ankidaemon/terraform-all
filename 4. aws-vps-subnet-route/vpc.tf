resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-vpc"
  }
}

resource "aws_subnet" "custom_public_subnet" {
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Terraform Public Subnet"
  }
}

resource "aws_subnet" "custom_private_subnet" {
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Terraform Private Subnet"
  }
}

resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "Terraform IGW"
  }
}

resource "aws_route_table" "custom_public_route" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = var.cidr_allow_all
    gateway_id = aws_internet_gateway.custom_igw.id
  }

  tags = {
    Name = "Terraform public subnet route"
  }
}

resource "aws_route_table_association" "web-public-rt" {
  subnet_id = aws_subnet.custom_public_subnet.id
  route_table_id = aws_route_table.custom_public_route.id
}