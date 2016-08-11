resource "aws_security_group" "kube_master_elb" {

  name = "${var.cluster_name}-elb"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["${var.cidr_block}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.cluster_name}"
    Environment = "${var.env_name}"
  }
}

resource "aws_security_group" "kube_master" {
  name        = "${var.cluster_name}"
  vpc_id      = "${var.vpc_id}"

  # allow internal SSH traffic (from bastions etc)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["${var.cidr_block}"]
  }

  ingress {
    from_port       = 2379
    to_port         = 2380
    protocol        = "TCP"
    security_groups = ["${var.etcd_security_group}"]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "TCP"
    security_groups = ["${aws_security_group.kube_master_elb.id}"]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.cluster_name}"
    Environment = "${var.env_name}"
  }
}
