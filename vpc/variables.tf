variable "aws_access_key_id" {
  type        = "string"
  description = "AWS Access Key ID"
}

variable "aws_secret_access_key" {
  type        = "string"
  description = "AWS Secret Access Key ID"
}

variable "aws_region" {
  type        = "string"
  description = "AWS Region"
}

variable "cidr_range" {
  type        = "string"
  description = "CIDR block"
}

variable "name" {
  type        = "string"
  description = "Name"
}

variable "aws_availability_zones" {
  type        = "list"
  description = "A list of availability zones to operate in"

  default = [
    "eu-west-1a",
    "eu-west-1b",
    "eu-west-1c",
  ]
}

variable "hosted_zone_name" {
  type        = "string"
  description = "Name of hosted zone"
}

variable "ssh_pubkey" {
  type        = "string"
  description = "Path to the SSH public key"
}
