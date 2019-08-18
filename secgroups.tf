resource "aws_security_group" "bastion_sg"{
  name = "bastion-ssm-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "host_sg"{
  name = "host-ssm-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "endpoints_sg"{
  name = "endpoints-ssm-sg"
  vpc_id = aws_vpc.main.id
}

#=============================================================================#
#                    BASTION SECURITY GROUP ROLES
#=============================================================================#


resource "aws_security_group_rule" "allow_bastion_443_from_endpoints" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = aws_security_group.endpoints_sg.id
  security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "allow_bastion_443_to_endpoints" {
  type = "egress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = aws_security_group.endpoints_sg.id
  security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "allow_bastion_ssh_to_host" {
  type = "egress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = aws_security_group.host_sg.id
  security_group_id = aws_security_group.bastion_sg.id
}

#=============================================================================#
#                    HOST SECURITY GROUP ROLES
#=============================================================================#

resource "aws_security_group_rule" "allow_host_ssh_from_bastion" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id = aws_security_group.host_sg.id
}

#=============================================================================#
#                    ENDPOINTS SECURITY GROUP ROLES
#=============================================================================#

resource "aws_security_group_rule" "allow_endpoints_443_from_bastion" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id = aws_security_group.endpoints_sg.id
}

resource "aws_security_group_rule" "allow_endpoints_443_to_bastion" {
  type = "egress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id = aws_security_group.endpoints_sg.id
}