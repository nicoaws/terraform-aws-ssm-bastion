output "bastion_instance_id" {
    value = aws_instance.bastion.id
}

output "host_instance_id" {
    value = aws_instance.host.id
}