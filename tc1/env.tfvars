resource_group = {
  name = "sample"
  location = "east us"
}
vnet_details = {
  name = "vnet"
  address_space = [ "192.168.0.0/16" ]
}
subnet_details = {
  name = [ "web", "app", "db"]
  address_prefixes = [ "192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24" ]
}
vm_details = {
  admin_username = "admin"
  admin_password = "admin@123456"
  size = "Standard B1_s"
}
numberofvms = 3