variable "region" {
  description = "YC region"
  type        = string
  default     = "ru-central1-b"
}

// yc compute image list --folder-id standard-images | grep -i ubuntu | grep '22-04' | grep 2023
variable "image_family" {
  description = "Compute Instance Image Family"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "ssh_port" {
  description = "SSH Port"
  type        = number
#  default     = 2222
}

variable "ssh_user" {
  description = "SSH User Name"
  type        = string
#  default     = "kofe"
}

variable "ssh_public_key_path" {
  description = "SSH Public Key File Path"
  type        = string
#  default     = "~/.ssh/authorized_keys"
}

variable "ssh_private_key_path" {
  description = "SSH Privat Key File Path"
  type        = string
#  default     = "~/.ssh/kofe.ed"
}

variable "instance_name" {
  description = "Instance Name"
  type        = string
  default     = "yc-test"
}

// https://cloud.yandex.ru/docs/compute/concepts/vm-platforms
variable "instance_platform" {
  description = "Instance Platform"
  type        = string
  default     = "standard-v1"
}

variable "core_fraction" {
  description = "Compute Fraction (%)"
  type        = number
  default     = 100
}


variable "cores" {
  description = "Compute Instance Cores Number"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Compute Instance Memory Count"
  type        = number
  default     = 4
}

variable "playbook" {
  description = "Ansible Playbook"
  type        = string
  default     = "scripts/web.yaml"
}

variable "php_user" {
  description = "User for run php-fpm"
  type        = string
  default     = "www-data"
}

