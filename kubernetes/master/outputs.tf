output "master_dns_name" {
  value = "${aws_elb.kube_master.dns_name}"
}
