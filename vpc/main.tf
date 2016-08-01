/**
 * Module usage:
 *
 *     module "vpc" {
 *       source = "modules/vpc"
 *
 *       name = "${var.name}"
 *
 *       aws_access_key_id      = "${var.aws_access_key_id}"
 *       aws_secret_access_key  = "${var.aws_secret_access_key}"
 *       aws_region             = "${var.aws_region}"
 *       aws_availability_zones = "${var.aws_availability_zones}"
 *
 *       cidr_range       = "10.0.0.0/16"
 *       ssh_pubkey       = "./relative/path/to/foo.pub"
 *       hosted_zone_name = "example.com"
 *     }
 *
 */

provider "aws" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region     = "${var.aws_region}"
}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_range}"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    EnvironmentName = "${var.name}"
    Name            = "${var.name}"
    Region          = "${var.aws_region}"
    Range           = "${var.cidr_range}"
  }
}

resource "aws_vpc_dhcp_options" "dns_search_path" {
  domain_name         = "priv.${var.hosted_zone_name}"
  domain_name_servers = ["${cidrhost(var.cidr_range, 2)}"]

  tags {
    Name       = "${var.name} - FQDN search"
    DomainName = "${var.hosted_zone_name}"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_search_path_assoc" {
  dhcp_options_id = "${aws_vpc_dhcp_options.dns_search_path.id}"
  vpc_id          = "${aws_vpc.vpc.id}"
}

resource "aws_internet_gateway" "inet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    EnvironmentName = "${var.name}"
    Name            = "${var.name}"
    Region          = "${var.aws_region}"
  }
}

resource "template_file" "ssh_keypair" {
  template = "${file(var.ssh_pubkey)}"
}

resource "aws_key_pair" "ssh_keypair" {
  key_name   = "${var.name}"
  public_key = "${template_file.ssh_keypair.rendered}"
}
