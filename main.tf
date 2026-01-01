resource "azurerm_resource_group" "rg1" {
  name     = "rg_lake"
  location = "Central India"
}

resource "azurerm_virtual_network" "vnet_river" {
  name                = "vnet_lake"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_subnet" "snet_canal" {
  name                 = "snet1"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet_river.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "vm01-nic"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet_canal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                            = "vm01"
  resource_group_name             = azurerm_resource_group.rg1.name
  location                        = azurerm_resource_group.rg1.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "admin@1234"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

