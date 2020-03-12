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
  device_name = var.device_name
  volume_id   = aws_ebs_volume.ebs_vol.id
  instance_id = aws_instance.ec2_with_ebs.id
}

## Volume unmount before terraform destroy
resource "null_resource" "ebs_unmount" {
  depends_on = [aws_volume_attachment.ebs_vol_att, aws_instance.ec2_with_ebs]
  
  ## run unmount commands when destroying the data volume
  provisioner "remote-exec" {
    when = destroy
    on_failure = continue
    connection {
      type = "ssh"
      agent = false
      timeout = "60s"
      host = aws_instance.ec2_with_ebs.public_ip
      user = "ec2-user"
      private_key = file("ec2-keys.ppk")
    }
    inline = [var.dataUmount]
  }
}