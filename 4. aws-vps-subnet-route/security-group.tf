resource "aws_security_group" "custom_secuity_group_pub" {
  name = "custom_secuity_group_public_subnet"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = var.http_port
    to_port = var.http_port
    protocol = var.tcp
    cidr_blocks = [var.cidr_allow_all]
  }

  ingress {
    from_port = var.ssl_port
    to_port = var.ssl_port
    protocol = var.tcp
    cidr_blocks = [var.cidr_allow_all]
  }

  ingress {
    from_port = var.ssh_port
    to_port = var.ssh_port
    protocol = var.tcp
    cidr_blocks =  [var.cidr_allow_all]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.private_subnet_cidr]
  }

  vpc_id=aws_vpc.custom_vpc.id

  tags = {
    Name = "Terraform public Server SG"
  }
}

resource "aws_security_group" "custom_secuity_group_pri"{
  name = "custom_secuity_group_private_subnet"
  description = "Allow traffic from custom_secuity_group_pub subnet"

  ingress {
    from_port = var.ssh_port
    to_port = var.ssh_port
    protocol = var.tcp
    cidr_blocks = [var.public_subnet_cidr]
  }

  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "Terraform private resources SG"
  }
}