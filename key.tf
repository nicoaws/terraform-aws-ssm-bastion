resource "tls_private_key" "bastion" {
  algorithm = "RSA"
}

resource "local_file" "private_key" {
  content = tls_private_key.bastion.private_key_pem
  filename = "host_key.pem"
}