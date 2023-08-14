variable "region" {
  description   = "YC region"
  type          = string
  default       = "ru-central1-b"
}

// yc compute image list --folder-id standard-images | grep -i ubuntu | grep '22-04' | grep 2023
variable "image_family" {
  description   = "Compute Instance Image Family"
  type          = string
  default       = "ubuntu-2204-lts"
}

variable "ssh_key_path" {
  description   = "SSH Public Key File Path"
  type          = string
  default       = "~/.ssh/authorized_keys"
}

variable "instance_name" {
  description   = "Instance Name"
  type          = string
  default       = "yc-test"
}

// https://cloud.yandex.ru/docs/compute/concepts/vm-platforms
variable "instance_platform" {
  description   = "Instance Platform"
  type          = string
  default       = "standard-v1"
}

variable "core_fraction" {
  description   = "Compute Fraction (%)"
  type          = number
  default       = 100
}


variable "cores" {
  description   = "Compute Instance Cores Number"
  type          = number
  default       = 2
}

variable "memory" {
  description   = "Compute Instance Memory Count"
  type          = number
  default       = 4
}

