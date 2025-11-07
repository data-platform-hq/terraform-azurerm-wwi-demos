terraform {
  required_version = ">=1.3"

  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.9.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.5"
    }
  }
}
