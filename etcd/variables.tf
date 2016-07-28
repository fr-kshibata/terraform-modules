variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}
variable "aws_region" {}

variable "aws_availability_zones" {
  type = "list"
}

variable "cluster_name" {}
variable "env_name" {}

variable "vpc_id" {}
variable "cidr_block" {}

variable "subnets" {
  type = "list"
}

variable "image_id" {}
variable "instance_type" {}

variable "ssh_key_name" {}

variable "cluster_size" {
  default = "3"
}

variable "discovery_token" {}
