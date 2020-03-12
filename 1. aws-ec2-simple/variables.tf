variable "region" {
  default = "ap-south-1"
}

variable "AWS_ACCESS_KEY_ID" {}

variable "AWS_SECRET_ACCESS_KEY" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "amis" {
  type = map(string)

  default = {
    ap-south-1 = "ami-0d9462a653c34dab7"
    me-south-1 = "ami-0e0e68bcf15b6f5cd"
  }
}

