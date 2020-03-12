resource "aws_instance" "ec2_with_ebs" {
  ami           = lookup(var.amis, var.region)
  instance_type = var.instance_type
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Terraform-EC2-WiTH-EBS"
  }
}

resource "aws_ebs_volume" "ebs_vol" {
  availability_zone = data.aws_availability_zones.available.names[0]
  size              = 2

  tags = {
    Name = "Terraform-EBS"
  }
}

resource "aws_volume_attachment" "ebs_vol_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_vol.id
  instance_id = aws_instance.ec2_with_ebs.id
}