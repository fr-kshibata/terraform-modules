 Module usage:

     module "vpc" {
       source = "modules/vpc"

       name = "${var.name}"

       aws_access_key_id      = "${var.aws_access_key_id}"
       aws_secret_access_key  = "${var.aws_secret_access_key}"
       aws_region             = "${var.aws_region}"
       aws_availability_zones = "${var.aws_availability_zones}"

       cidr_range       = "10.0.0.0/16"
       ssh_pubkey       = "./relative/path/to/foo.pub"
       hosted_zone_name = "example.com"
     }



## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| aws_access_key_id | AWS Access Key ID | - | yes |
| aws_secret_access_key | AWS Secret Access Key ID | - | yes |
| aws_region | AWS Region | - | yes |
| cidr_range | CIDR block | - | yes |
| name | Name | - | yes |
| aws_availability_zones | A list of availability zones to operate in | - | yes |
| hosted_zone_name | Name of hosted zone | - | yes |
| ssh_pubkey | Path to the SSH public key | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC ID |
| internal_subnets | Internal Subnets |
| external_subnets | External Subnets |
| cidr_block | CIDR Block |

