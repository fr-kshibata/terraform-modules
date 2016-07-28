
 Module usage:

     module "etcd" {
       source = "github.com/imjoshholloway/terraform-modules/etcd"

       name = "cluster-name"
       env_name = "env-name"

       aws_access_key_id      = "some-id"
       aws_secret_access_key  = "some-key"
       aws_region             = "eu-west-1"
       aws_availability_zones = ["eu-west-1a", "eu-west-1b"]

       vpc_id     = "some-vpc-id"
       cidr_block = "10.0.0.0/8"
       subnets    = ["subnet-a", "subnet-b"]

       instance_type    = "t2.medium"
       image_id         = "some-coreos-ami"

       cluster_size     = 3
    }


## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| name | The Cluster Name | - | yes |
| env_name | The Environment Name | - | yes |
| aws_access_key_id | AWS Access Key ID | - | yes |
| aws_secret_access_key | AWS Secret Access Key ID | - | yes |
| aws_region | AWS Region | - | yes |
| vpc_id | VPC ID | - | yes |
| subnets | Subnets | - | yes |
| instance_type | The AWS Instance Type | t2.medium | no |
| image_id | AMI ID | - | yes |
| cluster_size | The Cluster Size | 3 | no |

## Outputs

| Name | Description |
|------|-------------|
| elb_security_group | Security group of the ELB |
| elb_dns_name | Internal ELB DNS Name |

