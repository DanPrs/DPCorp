terraform {
  required_version = ">= 1.05"
}

# VNet Resource Group
resource "azurerm_resource_group" "RG-VNet" {
  name     = "RG-VNet-${var.environment}"
  location = "East US"
}

# NSG Frontend
resource "azurerm_network_security_group" "NSG1" {
  name                = "NSG1-${var.environment}"
  location            = azurerm_resource_group.RG-VNet-${var.environment}.location
  resource_group_name = azurerm_resource_group.RG-VNet-${var.environment}.name
}

# NSG Application
resource "azurerm_network_security_group" "NSG2" {
  name                = "NSG2-Test"
  location            = azurerm_resource_group.RG-VNet-${var.environment}.location
  resource_group_name = azurerm_resource_group.RG-VNet-${var.environment}.name
}

# NSG Data
resource "azurerm_network_security_group" "NSG3" {
  name                = "NSG3-${var.environment}"
  location            = azurerm_resource_group.RG-VNet-${var.environment}.location
  resource_group_name = azurerm_resource_group.RG-VNet-${var.environment}.name
}

# DDOS
resource "azurerm_network_ddos_protection_plan" "DDOS Protection" {
  name                = "DDOS-${var.environment}"
  location            = azurerm_resource_group.RG-VNet-${var.environment}.location
  resource_group_name = azurerm_resource_group.RG-VNet-${var.environment}.name
}

# VNet
resource "azurerm_virtual_network" "VNet" {
  name                = "VNet-${var.environment}"
  location            = azurerm_resource_group.RG-VNet-${var.environment}.location
  resource_group_name = azurerm_resource_group.RG-VNet-${var.environment}.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.DDOS-${var.environment}.id
    enable = true
  }

  # FrontEnd subnet
  subnet {
    name           = "subnet1-${var.environment}"
    address_prefix = var.sub1_address_prefix
    security_group = azurerm_network_security_group.NSG1-${var.environment}.id
  }

  # Application subnet
  subnet {
    name           = "subnet2-${var.environment}"
    address_prefix = var.sub2_address_prefix
    security_group = azurerm_network_security_group.NSG2-${var.environment}.id
  }

  # Data subnet
  subnet {
    name           = "subnet3-${var.environment}"
    address_prefix = var.sub3_address_prefix
    security_group = azurerm_network_security_group.NSG3-${var.environment}.id
  }

  tags = {
    environment = var.environment
  }
}
