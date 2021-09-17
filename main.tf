# Terraform Configuration
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.76.0"
    }
  }
}

# Azure Provider
provider "azurerm" {
  # Configuration options
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features {}
}

# vNet Test Resource Group
resource "azurerm_resource_group" "RG-VNet-Test" {
  name     = "RG-VNet-Test"
  location = "East US"
}

resource "azurerm_network_security_group" "VNet-Prod-NSG01" {
  name                = "VNet-Prod-NSG01"
  location            = azurerm_resource_group.RG-VNet-Test.location
  resource_group_name = azurerm_resource_group.RG-VNet-Test.name
}

resource "azurerm_network_ddos_protection_plan" "DDOS-Prod" {
  name                = "DDOS-Prod"
  location            = azurerm_resource_group.RG-VNet-Test.location
  resource_group_name = azurerm_resource_group.RG-VNet-Test.name
}

# vNet
resource "azurerm_virtual_network" "VNet-Prod" {
  name                = "VNet-Prod"
  location            = azurerm_resource_group.RG-VNet-Test.location
  resource_group_name = azurerm_resource_group.RG-VNet-Test.name
  address_space       = ["10.10.0.0/16"]
  dns_servers         = ["1.1.1.1", "1.0.0.1"]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.example.id
    enable = true
  }

  subnet {
    name           = "subnet1"
    address_prefix = "10.10.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.10.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.10.3.0/24"
    security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "Production"
  }
}
