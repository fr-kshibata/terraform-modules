// VPC ID
output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

// Internal Subnets
output "internal_subnets" {
  value = "${split(",",join(",", aws_subnet.internal_subnets.*.id))}"
}

// External Subnets
output "external_subnets" {
  value = "${split(",",join(",", aws_subnet.external_subnets.*.id))}"
}

output "cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}
