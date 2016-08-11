output "cluster_security_group" {
  value = "${aws_security_group.cluster.id}"
}

output "elb_security_group" {
  value = "${aws_security_group.elb.id}"
}

output "elb_dns_name" {
  value = "${aws_elb.internal.dns_name}"
}
