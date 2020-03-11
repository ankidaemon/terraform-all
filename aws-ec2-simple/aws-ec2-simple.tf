resource "aws_instance" "my_first_ec2" {
  ami           = lookup(var.amis, var.region)
  instance_type = var.instance_type
}

