resource "aws_instance" "bastion" {
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.private_subnets.0.id
  vpc_security_group_ids = [ aws_security_group.bastion_sg.id ]
  associate_public_ip_address = false
  source_dest_check = false
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_instance_profile.name
  tags = {
    Name = "bastion-nossh"
  }
}


resource "aws_instance" "host" {
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.private_subnets.0.id
  vpc_security_group_ids = [ aws_security_group.host_sg.id ]
  user_data = data.template_cloudinit_config.cloud_init_config_host.rendered
  associate_public_ip_address = false
  
  tags = {
    Name = "host-nossh"
  }
}

