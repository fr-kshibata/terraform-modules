
resource "aws_iam_instance_profile" "kube_master" {
  name  = "${var.cluster_name}-${var.aws_region}"
  roles = ["${aws_iam_role.kube_master.name}"]
}

resource "aws_iam_role" "kube_master" {
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

resource "aws_iam_role_policy" "kube_master" {
  name = "kube-masters"
  role = "${aws_iam_role.kube_master.id}"

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
