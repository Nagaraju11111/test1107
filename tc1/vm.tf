resource "azurerm_linux_virtual_machine" "pdpvm" {
  count = var.numberofvms
  name                = "vm-${count.index}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  size                = var.vm_details.size
  admin_username      = var.vm_details.admin_username
  admin_password      = var.vm_details.admin_password
  network_interface_ids = [ azurerm_network_interface.pdpnic[count.index].id ]  
  disable_password_authentication = false
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.pdpnic
  ]
}
