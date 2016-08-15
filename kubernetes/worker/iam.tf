
resource "aws_iam_instance_profile" "kube_worker" {
  name  = "${var.cluster_name}-${var.aws_region}"
  roles = ["${aws_iam_role.kube_worker.name}"]
}

resource "aws_iam_role" "kube_worker" {
  name = "${var.cluster_name}-${var.aws_region}"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {"AWS": "*"},
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "kube_worker" {
  name = "kube-workers"
  role = "${aws_iam_role.kube_worker.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*",
        "autoscaling:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
