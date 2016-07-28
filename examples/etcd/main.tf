# Configure the AWS Provider
provider "aws" {
   access_key = "${var.aws_access_key_id}"
   secret_key = "${var.aws_secret_access_key}"
   region = "${var.aws_region}"
}

/*resource "terraform_remote_state" "network" {
    backend = "s3"
    config {
        bucket      = "${var.remote_state_bucket}"
        key         = "state/network.tfstate"
        region      = "eu-central-1"
        profile     = "newprod"
     }
}*/


module "etcd" {
   source = "../../etcd"

    cluster_name = "etcd"
    env_name     = "${var.env_name}"

    aws_access_key_id      = "${var.aws_access_key_id}"
    aws_secret_access_key  = "${var.aws_secret_access_key}"
    aws_region             = "${var.aws_region}"
    aws_availability_zones = ["${var.aws_availability_zones}"]

    #vpc_id     = "${terraform_remote_state.network.output.vpc_id}"
    vpc_id      = "vpc-148f8c7d"
    cidr_block  = "${var.cidr_block}"
    subnets     = ["subnet-b4857bdc", "subnet-27a2ab5c"]
    #subnets    = ["${terraform_remote_state.network.output.internal_subnets}"]

    ssh_key_name = "${var.env_name}"

    instance_type    = "${var.instance_type}"
    image_id         = "${var.image_id}"

    discovery_token  = "${var.discovery_token}"
}

