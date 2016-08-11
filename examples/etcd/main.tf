# Configure the AWS Provider
provider "aws" {
   access_key = "${var.aws_access_key_id}"
   secret_key = "${var.aws_secret_access_key}"
   region = "${var.aws_region}"
}

data "terraform_remote_state" "network" {
    backend = "s3"
    config {
        bucket      = "${var.remote_state_bucket}"
        key         = "state/network.tfstate"
        region      = "eu-central-1"
        profile     = "newprod"
     }
}

module "etcd" {
   source = "../../etcd"

    cluster_name = "etcd"
    env_name     = "${var.env_name}"

    aws_access_key_id      = "${var.aws_access_key_id}"
    aws_secret_access_key  = "${var.aws_secret_access_key}"
    aws_region             = "${var.aws_region}"
    aws_availability_zones = ["${var.aws_availability_zones}"]

    vpc_id     = "${data.terraform_remote_state.network.vpc_id}"
    cidr_block = "${data.terraform_remote_state.network.cidr_block}"
    subnets    = ["${data.terraform_remote_state.network.internal_subnets}"]

    ssh_key_name = "${var.env_name}"

    instance_type    = "${var.instance_type}"
    image_id         = "${var.image_id}"

    cluster_size = 3
}
output "etcd_security_group" {
   value = "${module.etcd.cluster_security_group}"
}

output "etcd_dns_name" {
   value = "${module.etcd.elb_dns_name}"
}
