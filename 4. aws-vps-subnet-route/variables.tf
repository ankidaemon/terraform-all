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

variable "cidr_allow_all" {
  default = "0.0.0.0/0"
}

variable "tcp" {
  default = "tcp"
}

variable "http_port" {
  default = "80"
}

variable "ssl_port" {
  default = "443"
}

variable "ssh_port" {
  default = "22"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}