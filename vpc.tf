resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "bastion-ssm-vpc"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.private_subnet_range,2,count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index%length(data.aws_availability_zones.available.names))

  tags = {
    Name = "bastion-ssm-private-subnet-${element(data.aws_availability_zones.available.names, count.index%length(data.aws_availability_zones.available.names))}"
  }
}

# Add default routes to public subnet RTR
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "bastion-ssm-route-table"
  }
}

resource "aws_route_table_association" "route_table_associations" {
  count = length(data.aws_availability_zones.available.names)
  subnet_id = element(aws_subnet.private_subnets.*.id,count.index)
  route_table_id = aws_route_table.route_table.id
}