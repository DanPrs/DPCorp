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

# Hub VNet
module "VNet-Hub" {
  source              = "./vnet"
  environment         = "Hub"
  address_space       = ["10.0.0.0/22"]
  dns_servers         = ["1.1.1.1", 
                        "1.0.0.2"]
  sub1_address_prefix = "10.0.1.0/24"
  sub2_address_prefix = "10.0.2.0/24"
  sub3_address_prefix = "10.0.3.0/24"
}

# Test VNet
module "VNet-Test" {
  source              = "./vnet"
  environment         = "Test"
  address_space       = ["10.10.0.0/22"]
  dns_servers         = ["1.1.1.1", 
                        "1.0.0.2"]
  sub1_address_prefix = "10.10.1.0/24"
  sub2_address_prefix = "10.10.2.0/24"
  sub3_address_prefix = "10.10.3.0/24"
}

# Prod VNet
module "VNet-Prod" {
  source              = "./vnet"
  environment         = "Prod"
  address_space       = ["10.20.0.0/22"]
  dns_servers         = ["1.1.1.1", 
                        "1.0.0.2"]
  sub1_address_prefix = "10.20.1.0/24"
  sub2_address_prefix = "10.20.2.0/24"
  sub3_address_prefix = "10.20.3.0/24"
}

# VNet Peering Test to Hub
resource "azurerm_virtual_network_peering" "example-1" {
  name                      = "peer1to2"
  resource_group_name       = azurerm_resource_group.VNet-Hub.name
  virtual_network_name      = azurerm_virtual_network.VNet-Test.name
  remote_virtual_network_id = azurerm_virtual_network.VNet-Hub.id
}

# VNet Peering Hub to Test
resource "azurerm_virtual_network_peering" "example-2" {
  name                      = "peer2to1"
  resource_group_name       = azurerm_resource_group.VNet-Hub.name
  virtual_network_name      = azurerm_virtual_network.VNet-Hub.name
  remote_virtual_network_id = azurerm_virtual_network.VNet-Test.id
}