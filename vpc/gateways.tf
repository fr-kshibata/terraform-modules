resource "aws_eip" "gateway_eip" {
  count = "${length(var.aws_availability_zones)}"

  vpc = true
}

resource "aws_nat_gateway" "gateway" {
  count = "${length(var.aws_availability_zones)}"

  subnet_id     = "${element(aws_subnet.external_subnets.*.id, count.index)}"
  allocation_id = "${element(aws_eip.gateway_eip.*.id, count.index)}"
}
