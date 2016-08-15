resource "aws_launch_configuration" "kube_worker" {
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.ssh_key_name}"
  enable_monitoring           = true
  security_groups             = ["${aws_security_group.kube_worker.id}", "${var.etcd_security_group}"]
  iam_instance_profile        = "${aws_iam_instance_profile.kube_worker.name}"

  root_block_device {
    volume_type             = "gp2"
    volume_size             = 20
    delete_on_termination   = true
  }

  user_data = "${template_file.userdata.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "kube_worker" {
  name                      = "${var.cluster_name}"
  availability_zones        = ["${var.aws_availability_zones}"]
  vpc_zone_identifier       = ["${var.subnets}"]

  desired_capacity          = "${var.cluster_size}"
  max_size                  = "${var.cluster_size}"
  min_size                  = "${var.cluster_size}"

  default_cooldown          = 300
  health_check_grace_period = 300
  health_check_type         = "EC2"
  termination_policies      = ["OldestInstance"]
  force_delete              = true

  launch_configuration      = "${aws_launch_configuration.kube_worker.name}"
#  load_balancers            = ["${aws_elb.kube_worker.name}"]

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.env_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Role"
    value               = "kube-worker"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "template_file" "userdata" {
  template = "${file("${path.module}/user_data.yml")}"

  vars {
    master_dns_name = "${var.master_dns_name}"
    etcd_dns_name   = "${var.etcd_dns_name}"
    K8S_VER = "v1.3.4"
  }

  lifecycle {
    create_before_destroy = true
  }
}
