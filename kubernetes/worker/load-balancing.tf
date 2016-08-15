/*resource "aws_elb" "kube_worker" {
  name                        = "${var.cluster_name}"
  subnets                     = ["${var.subnets}"]
  security_groups             = ["${aws_security_group.kube_worker_elb.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
  connection_draining         = false
  connection_draining_timeout = 300
  internal                    = true


  listener {
    instance_port       = 443
    instance_protocol   = "tcp"
    lb_port             = 443
    lb_protocol         = "tcp"
    ssl_certificate_id  = ""
  }

  listener {
    instance_port       = 8080
    instance_protocol   = "http"
    lb_port             = 8080
    lb_protocol         = "http"
    ssl_certificate_id  = ""
  }

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/healthz"
    interval            = 5
  }

  tags {
    Name        = "${var.cluster_name}"
    Environment = "${var.env_name}"
    Role        = "kube-worker"
  }
}*/
