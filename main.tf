terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.96.1"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
#  service_account_key_file = file("~/.keys/yc_authorized_key.json")
  zone = var.region
}

data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

data "template_file" "user_data" {
  template = file("scripts/user-data.yaml")
  vars = {
    ssh-public-key = file(var.ssh_key_path)
  }
}

resource "yandex_vpc_network" "test" {
  name = "test-network"
}

resource "yandex_vpc_subnet" "test" {
  network_id = yandex_vpc_network.test.id
  v4_cidr_blocks = ["10.100.0.0/24"]
}

resource "yandex_compute_instance" "test" {
  name        = "yc-test"
  hostname    = "yc-test"
  platform_id = "standard-v1"					// https://cloud.yandex.ru/docs/compute/concepts/vm-platforms
//  zone        = "ru-central1-a"

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id		// yc compute image list --folder-id standard-images | grep -i ubuntu | grep '22-04' | grep 2023
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.test.id
    nat = true
  }

  metadata = {
    user-data = data.template_file.user_data.rendered
  }
}

resource "yandex_vpc_security_group" "test" {
  name        = "test security group"
  description = "test security group"
  network_id  = yandex_vpc_network.test.id
/*
  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
*/
  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 2222
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = -1
    to_port        = -1
  }
}
