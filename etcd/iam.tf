
resource "aws_iam_instance_profile" "etcd_iam_profile" {
  name  = "${var.cluster_name}-${var.aws_region}"
  roles = ["${aws_iam_role.etcd_iam_role.name}"]
}

resource "aws_iam_role" "etcd_iam_role" {
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

resource "aws_iam_role_policy" "etcd_iam_policy" {
  name = "etcd-peers"
  role = "${aws_iam_role.etcd_iam_role.id}"

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
