variable "resource_group" {
  type= object({
    name = string
    location= string
  })
}
variable "vnet_details" {
  type= object({
    name = string
    address_space = list(string)
  })
}
variable "subnet_details" {
  type=object ({
    name = list(string)
    address_prefixes= list(string)
  })
}
variable "vm_details" {
  type = object ({
   admin_username= string
    admin_password= string
    size = string
  })
}
variable "numberofvms" {
  type = number
}