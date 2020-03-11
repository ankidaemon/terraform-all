resource "aws_instance" "ec2_with_ebs" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  availability_zone = data.aws_availability_zones.available.names[0]
  key_name = var.key_name
  
  user_data = data.template_file.ec2_userdata.rendered

  tags = {
    Name = "Terraform-EC2-EBS-USERDATA"
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