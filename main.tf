terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.76.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# vNet Test Resource Group
resource "azurerm_resource_group" "RG-VNet-Test" {
  name     = "RG-VNet-Test"
  location = "East US"
}