resource "aws_vpc_endpoint" "ssm_messages" {
  vpc_id            = "${aws_vpc.main.id}"
  service_name      = "com.amazonaws.eu-west-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids = aws_subnet.private_subnets.*.id
  security_group_ids = [ aws_security_group.endpoints_sg.id ]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = "${aws_vpc.main.id}"
  service_name      = "com.amazonaws.eu-west-1.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids = aws_subnet.private_subnets.*.id
  security_group_ids = [ aws_security_group.endpoints_sg.id ]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = "${aws_vpc.main.id}"
  service_name      = "com.amazonaws.eu-west-1.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids = aws_subnet.private_subnets.*.id
  security_group_ids = [ aws_security_group.endpoints_sg.id ]
  private_dns_enabled = true
}