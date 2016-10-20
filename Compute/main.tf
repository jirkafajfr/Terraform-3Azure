# Create a Resource Group for Compute
resource "azurerm_resource_group" "dev" {
    name = "${var.ARM_COMPUTE_RESOURCE_GROUP}"
    location = "${var.ARM_LOCATION}"
}

# Create NIC for app01vm
resource "azurerm_network_interface" "dev" {
    name = "acctni"
    location = "West US"
    resource_group_name = "${azurerm_resource_group.dev.name}"

    ip_configuration {
        name = "testconfiguration1"
        subnet_id = "${var.ARM_SUBNET_ID}"
        private_ip_address_allocation = "dynamic"
    }
}

# Create a storage account for the app01vm
resource "azurerm_storage_account" "dev" {
    name = "${var.ARM_STORAGEACCT_NAME}"
    resource_group_name = "${azurerm_resource_group.dev.name}"
    location = "${var.ARM_LOCATION}"
    account_type = "Standard_LRS"

    tags {
        environment = "${var.ARM_ENVIRONMENT_TAG}"
    }
}

resource "azurerm_storage_container" "dev" {
    name = "vhds"
    resource_group_name = "${azurerm_resource_group.dev.name}"
    storage_account_name = "${azurerm_storage_account.dev.name}"
    container_access_type = "private"
}

resource "azurerm_virtual_machine" "dev" {
    name = "appvm01"
    location = "${var.ARM_LOCATION}"
    resource_group_name = "${azurerm_resource_group.dev.name}"
    network_interface_ids = ["${azurerm_network_interface.dev.id}"]
    vm_size = "Standard_A0"

    storage_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "14.04.2-LTS"
        version = "latest"
    }

    storage_os_disk {
        name = "myosdisk1"
        vhd_uri = "${azurerm_storage_account.dev.primary_blob_endpoint}${azurerm_storage_container.dev.name}/myosdisk1.vhd"
        caching = "ReadWrite"
        create_option = "FromImage"
    }

    os_profile {
        computer_name = "hostname"
        admin_username = "testadmin"
        admin_password = "Password1234!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags {
        environment = "${var.ARM_ENVIRONMENT_TAG}"
    }
}