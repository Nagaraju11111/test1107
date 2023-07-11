resource "azurerm_resource_group" "pdp" {
  name = var.resource_group.name
  location = var.resource_group.location
}
resource "azurerm_virtual_network" "pdpvnet" {
  name                = var.vnet_details.name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  address_space       = var.vnet_details.address_space
  depends_on = [
    azurerm_resource_group.pdp
  ]
}
resource "azurerm_subnet" "pdpapp" {
  count =length(var.subnet_details.name)
  name                 = var.subnet_details.name[count.index]
  resource_group_name  = var.resource_group.name
  virtual_network_name = var.vnet_details.name
  address_prefixes     = [var.subnet_details.address_prefixes[count.index]]
  depends_on = [
    azurerm_resource_group.pdp,
    azurerm_virtual_network.pdpvnet
  ]

}