variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}
variable "aws_region" {}

variable "aws_availability_zones" {
  type = "list"
}

variable "env_name" {}

variable "cidr_block" {}

variable "image_id" {}
variable "instance_type" {}

variable "remote_state_bucket" {}
