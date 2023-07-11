terraform {
  backend "azurerm" {
    resource_group_name  = "<resource group name of storage account>"
    storage_account_name = "<name of storage account>"
    container_name       = "< name of the container in storage account>"
    key                  = "key name to store state file"
  }
}