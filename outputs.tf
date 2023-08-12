output "instance_public_ip" {
    value = yandex_compute_instance.test.network_interface[0].nat_ip_address
}

output "subnet_id" {
    value = yandex_vpc_subnet.test.id
}

output "ubuntu" {
    value = data.yandex_compute_image.ubuntu.name
}
