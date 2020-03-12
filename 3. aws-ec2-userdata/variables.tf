variable "region" {
  default = "ap-south-1"
}

variable "AWS_ACCESS_KEY_ID" {}

variable "AWS_SECRET_ACCESS_KEY" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "device_name" {
  default = "/dev/sdh"
}
variable "key_name" {
  default = "ec2-keys"
}

variable "dataUmount" {
  type = string
  default = "echo '***unmount***' && sudo umount /mnt/ec2-external-ebs/ "
}