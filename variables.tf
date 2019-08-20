data "aws_availability_zones" "available" {}

data "aws_ami" "amazon_linux_2" {
 most_recent = true
 owners = ["amazon"]
 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*x86_64-ebs"]
 }
 filter {
  name = "architecture"
  values = ["x86_64"]
 }
}

variable "instance_type" {
  type = "string"
  default = "t3a.micro"
}

variable "vpc_cidr" {
  type = "string"
  default = "10.0.0.0/16"
}

variable "private_subnet_range" {
  type = "string"
  default = "10.0.128.0/23"
}

variable "public_key_path" {
  type = "string"
  default = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  type = "string"
  default = "~/.ssh/id_rsa"
}

variable "bastion_ami_id" {
  type = "string"
  default = "ami-05bc70c954e6fbaa3"
}