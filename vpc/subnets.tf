resource "aws_subnet" "internal_subnets" {
  count = "${length(var.aws_availability_zones)}"

  availability_zone       = "${element(var.aws_availability_zones, count.index)}"
  cidr_block              = "${cidrsubnet(var.cidr_range, 7, count.index)}"
  map_public_ip_on_launch = false
  vpc_id                  = "${aws_vpc.vpc.id}"

  tags {
    AvailabilityZone = "${element(var.aws_availability_zones, count.index)}"
    EnvironmentName  = "${var.name}"
    Name             = "${var.name} - Internal ${element(var.aws_availability_zones, count.index)}"
    Range            = "${cidrsubnet(var.cidr_range, 7, count.index)}"
    Type             = "Internal"
  }
}

resource "aws_subnet" "external_subnets" {
  count = "${length(var.aws_availability_zones)}"

  availability_zone       = "${element(var.aws_availability_zones, count.index)}"
  cidr_block              = "${cidrsubnet(var.cidr_range, 7, count.index + 4)}"
  map_public_ip_on_launch = false
  vpc_id                  = "${aws_vpc.vpc.id}"

  tags {
    AvailabilityZone = "${element(var.aws_availability_zones, count.index)}"
    EnvironmentName  = "${var.name}"
    Name             = "${var.name} - External ${element(var.aws_availability_zones, count.index)}"
    Range            = "${cidrsubnet(var.cidr_range, 7, count.index)}"
    Type             = "External"
  }
}
