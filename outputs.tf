# ssh -i $(terraform output -raw ssh_key_path) -p $(terraform output -raw ssh_port) $(terraform output -raw ssh_user)@$(terraform output -raw instance_public_ip)
output "instance_public_ip" {
  value = yandex_compute_instance.test.network_interface[0].nat_ip_address
}

output "ssh_user" {
  value = var.ssh_user
}

output "ssh_port" {
  value = var.ssh_port
}

output "ssh_key_path" {
  value = var.ssh_private_key_path
}

output "subnet_id" {
  value = data.yandex_vpc_subnet.default.id
}

output "ubuntu" {
  value = data.yandex_compute_image.ubuntu.name
}
