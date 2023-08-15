terraform {
  required_providers {
    yandex                  = {
      source                = "yandex-cloud/yandex"
      version               = "0.96.1"
    }
    null                    = {}
  }
  required_version          = ">= 0.15"
}

provider "yandex" {
  zone                      = var.region
}

provider "null" {}

data "yandex_compute_image" "ubuntu" {
  family                    = var.image_family
}

data "template_file" "user_data" {
  template                  = file("scripts/user-data.yaml")
  vars = {
    user                    = var.ssh_user
    port                    = var.ssh_port
    ssh-public-key          = file(var.ssh_public_key_path)
  }
}

resource "yandex_vpc_network" "test" {
  name                      = "test-network"
}

resource "yandex_vpc_subnet" "test" {
  name                      = "test-subnet"
  description               = "test-subnet"
  network_id                = yandex_vpc_network.test.id
  v4_cidr_blocks            = ["10.100.0.0/24"]
}

resource "yandex_compute_instance" "test" {
  name                      = var.instance_name
  hostname                  = var.instance_name
  platform_id               = var.instance_platform

  resources {
    core_fraction           = var.core_fraction
    cores                   = var.cores
    memory                  = var.memory
  }

  boot_disk {
    initialize_params {
      image_id              = "${data.yandex_compute_image.ubuntu.id}"
    }
  }

  network_interface {
    subnet_id               = yandex_vpc_subnet.test.id
    nat                     = true
  }

  metadata = {
    user-data               = data.template_file.user_data.rendered
  }
}

resource "yandex_vpc_security_group" "test" {
  name                      = "test security group"
  description               = "test security group"
  network_id                = yandex_vpc_subnet.test.id

  ingress {
    protocol                = "TCP"
    description             = "HTTP"
    v4_cidr_blocks          = ["0.0.0.0/0"]
    port                    = 80
  }

  ingress {
    protocol                = "TCP"
    description             = "SSH"
    v4_cidr_blocks          = ["0.0.0.0/0"]
    port                    = 2222
  }

  egress {
    protocol                = "ANY"
    v4_cidr_blocks          = ["0.0.0.0/0"]
    from_port               = -1
    to_port                 = -1
  }
}

resource "null_resource" "test" {
  provisioner "remote-exec" {
    connection {
      type                  = "ssh"
      host                  = yandex_compute_instance.test.network_interface[0].nat_ip_address
      port                  = "${var.ssh_port}"
      user                  = var.ssh_user
      private_key           = file("${var.ssh_private_key_path}")
      agent                 = false
    }

    inline = ["exit"]
  }

  provisioner "local-exec" {
    command = <<EOT
        ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} -i '${yandex_compute_instance.test.network_interface[0].nat_ip_address}:${var.ssh_port},' \
        --private-key ${var.ssh_private_key_path} ${var.playbook} \
        --extra-vars '{"wait_script":"${path.cwd}/scripts/wait4finish-cloud-init.sh","username":"${var.ssh_user}"}'
        EOT
  }
}
