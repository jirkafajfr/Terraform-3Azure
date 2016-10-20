
# Create a resource group for Networking
resource "azurerm_resource_group" "network_rg" {
    name     = "${var.ARM_NETWORK_RESOURCE_GROUP}"
    location = "${var.ARM_LOCATION}"
}

# Create a virtual network in the resource group
resource "azurerm_virtual_network" "network_rg" {
  name                = "devNetwork"
  address_space       = ["10.0.0.0/16"]
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.network_rg.name}"

  subnet {
    name           = "WebSubnet"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "AppSubnet"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "DataSubnet"
    address_prefix = "10.0.3.0/24"
  }
}

