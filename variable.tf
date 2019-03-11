#Providers

variable "aws_region" {}
variable "aws_profile" {}

# VPC
variable "vpc_cidr" {}

#subnet
data "aws_availability_zones" "available" {}
variable "cidrs" {
    type = "map"
}

#key_part
variable "public_key_path" {}
variable "key_name" {}

#Instance
variable "instance_type" {}
variable "instance_ami" {}
variable "script_path" {}