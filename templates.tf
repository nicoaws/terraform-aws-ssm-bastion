data "template_file" "cloud_init_host" {
  template = file("templates/cloud-init-host.yml")
  vars = {
    bastion_public_key = tls_private_key.bastion.public_key_openssh
  }
}

data "template_cloudinit_config" "cloud_init_config_host" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = data.template_file.cloud_init_host.rendered
  }
}

# data "template_file" "cloud_init_bastion" {
#   template = file("templates/cloud-init-bastion.yml")
#   vars = {
#     bastion_private_key = indent(2,yamlencode(tls_private_key.bastion.private_key_pem))
#     bastion_public_key = tls_private_key.bastion.public_key_openssh
#   }
# }

# data "template_cloudinit_config" "cloud_init_config_bastion" {
#   gzip          = false
#   base64_encode = false

#   part {
#     content_type = "text/cloud-config"
#     content = data.template_file.cloud_init_bastion.rendered
#   }
# }