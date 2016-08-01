resource "aws_route_table" "internal_route_table" {
  count = "${length(var.aws_availability_zones)}"

  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    AvailabilityZone = "${element(var.aws_availability_zones, count.index)}"
    EnvironmentName  = "${var.name}"
    Name             = "${var.name} - Internal ${element(var.aws_availability_zones, count.index)}"
  }
}

resource "aws_route_table_association" "internal_route_association" {
  count = "${length(var.aws_availability_zones)}"

  route_table_id = "${element(aws_route_table.internal_route_table.*.id, count.index)}"
  subnet_id      = "${element(aws_subnet.internal_subnets.*.id, count.index)}"
}

resource "aws_route" "internal_internet" {
  count = "${length(var.aws_availability_zones)}"

  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.gateway.*.id, count.index)}"
  route_table_id         = "${element(aws_route_table.internal_route_table.*.id, count.index)}"
}

resource "aws_route_table" "external_route_table" {
  count = "${length(var.aws_availability_zones)}"

  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    AvailabilityZone = "${element(var.aws_availability_zones, count.index)}"
    EnvironmentName  = "${var.name}"
    Name             = "${var.name} - External ${element(var.aws_availability_zones, count.index)}"
  }
}

resource "aws_route_table_association" "external_route_association" {
  count = "${length(var.aws_availability_zones)}"

  route_table_id = "${element(aws_route_table.external_route_table.*.id, count.index)}"
  subnet_id      = "${element(aws_subnet.external_subnets.*.id, count.index)}"
}

resource "aws_route" "external_internet" {
  count = "${length(var.aws_availability_zones)}"

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.inet_gateway.id}"
  route_table_id         = "${element(aws_route_table.external_route_table.*.id, count.index)}"
}
