resource "aws_instance" "ec2_with_ebs" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  availability_zone = data.aws_availability_zones.available.names[0]
  key_name = var.key_name
  
  user_data = data.template_file.ec2_userdata.rendered

  subnet_id = aws_subnet.custom_public_subnet.id
  vpc_security_group_ids = [aws_security_group.custom_secuity_group_pub.id]

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
      private_key = file("ec2-keys.pem")
    }
    inline = [var.dataUmount]
  }
}

resource "aws_instance" "private_instance" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.custom_private_subnet.id
  vpc_security_group_ids = [aws_security_group.custom_secuity_group_pri.id]
  source_dest_check = false

  tags = {
    Name = "Terraform private_instance"
  }
}