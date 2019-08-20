resource "tls_private_key" "bastion" {
  algorithm = "RSA"
}

resource "local_file" "private_key" {
  content = tls_private_key.bastion.private_key_pem
  filename = "host_key.pem"
}

resource "aws_key_pair" "ssm-bastion-keypair" {
  key_name = "ssm-bastion-keypair"
  public_key = "${file(var.public_key_path)}"
}