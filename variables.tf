variable "region" {
  description   = "YC region"
  type          = string
  default       = "ru-central1-b"
}

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

