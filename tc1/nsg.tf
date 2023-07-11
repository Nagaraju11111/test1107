resource "azurerm_network_security_group" "pdpnsg" {
  name                = "appnsg"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  security_rule {
    name                       = "ssh"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allowalltcp"
    priority                   = 360
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 80
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [
    azurerm_resource_group.pdp
  ]

}
resource "azurerm_public_ip" "pdpip" {
  count =  var.numberofvms
  name                = "ip-${count.index}"
  resource_group_name = var.resource_group.name
  location = var.resource_group.location
  allocation_method   = "Dynamic"
  
  depends_on = [
    azurerm_resource_group.pdp
  ]
}
resource "azurerm_network_interface" "pdpnic" {
  count = var.numberofvms
  name                = "nic-${count.index}"
  resource_group_name = var.resource_group.name
  location = var.resource_group.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.pdpapp[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pdpip[count.index].id
  }
  depends_on = [
    azurerm_subnet.pdpapp,
    azurerm_public_ip.pdpip
  ]
}

resource "azurerm_network_interface_security_group_association" "pdpna" {
  count = var.numberofvms
  network_interface_id      = azurerm_network_interface.pdpnic[count.index].id 
  network_security_group_id = azurerm_network_security_group.pdpnsg.id
  depends_on = [
    azurerm_network_interface.pdpnic,
    azurerm_network_security_group.pdpnsg
  ]
}
