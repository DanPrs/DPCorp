# VNet Resource Group
resource "azurerm_resource_group" "RG-VNet" {
  name     = "RG-VNet-${var.environment}"
  location = "East US"
}

# NSG Frontend
resource "azurerm_network_security_group" "NSG1" {
  name                = "NSG1-${var.environment}"
  location            = azurerm_resource_group.RG-VNet.location
  resource_group_name = azurerm_resource_group.RG-VNet.name
}

# NSG Application
resource "azurerm_network_security_group" "NSG2" {
  name                = "NSG2-${var.environment}"
  location            = azurerm_resource_group.RG-VNet.location
  resource_group_name = azurerm_resource_group.RG-VNet.name
}

# NSG Data
resource "azurerm_network_security_group" "NSG3" {
  name                = "NSG3-${var.environment}"
  location            = azurerm_resource_group.RG-VNet.location
  resource_group_name = azurerm_resource_group.RG-VNet.name
}

# VNet
resource "azurerm_virtual_network" "VNet" {
  name                = "VNet-${var.environment}"
  location            = azurerm_resource_group.RG-VNet.location
  resource_group_name = azurerm_resource_group.RG-VNet.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  # FrontEnd subnet
  subnet {
    name           = "subnet1-${var.environment}"
    address_prefix = var.sub1_address_prefix
    security_group = azurerm_network_security_group.NSG1.id
  }

  # Application subnet
  subnet {
    name           = "subnet2-${var.environment}"
    address_prefix = var.sub2_address_prefix
    security_group = azurerm_network_security_group.NSG2.id
  }

  # Data subnet
  subnet {
    name           = "subnet3-${var.environment}"
    address_prefix = var.sub3_address_prefix
    security_group = azurerm_network_security_group.NSG3.id
  }

  tags = {
    environment = var.environment
  }
}
