resource "azurerm_resource_group" "rg1" {
    name =     "rg_lake"
    location = "Central India"
}

resource "azurerm_virtual_network" "vnet_river" {
name = "vnet_lake"
address_space = [ "10.0.0.0/16" ]
location = azurerm_resource_group.rg1.location
resource_group_name = azurerm_resource_group.rg1.name
}
