# etcd Example

This is an example of setting up a 3 node etcd-cluster using the etcd module.

## Setup

 - Create `terraform.tfvars` file with following:

 ```
aws_access_key_id = "[YOUR ACCESS KEY ID]"
aws_secret_access_key = "[YOUR SECRET KEY]"

env_name = "someenv"

# CoreOS image (1068.8.0)
image_id = "ami-7b7a8f14"
instance_type = "t2.medium"

# S3 bucket to pull the network state from
remote_state_bucket = "my-s3-bucket"
```
