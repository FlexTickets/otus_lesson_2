terraform {
  required_providers {
    yandex                  = {
      source                = "yandex-cloud/yandex"
      version               = ">=0.96"
    }
    null                    = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
  }
  required_version          = ">= 0.15"
}

provider "yandex" {
  zone                      = var.region
}
