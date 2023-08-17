output "instance_public_ip" {
  value = yandex_compute_instance.test.network_interface[0].nat_ip_address
}

output "ssh_user" {
  value = var.ssh_user
}

output "ssh_port" {
  value = var.ssh_port
}

output "subnet_id" {
  value = data.yandex_vpc_subnet.default.id
}

output "ubuntu" {
  value = data.yandex_compute_image.ubuntu.name
}
