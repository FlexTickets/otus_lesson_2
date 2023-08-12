variable "region" {
  description   = "YC region"
  type          = string
  default       = "ru-central1-b"
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

