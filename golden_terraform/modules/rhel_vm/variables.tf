variable "name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "nic_id" { type = string }
variable "admin_username" { type = string }
variable "admin_password" { type = string, sensitive = true }
variable "size" { type = string, default = "Standard_B2s" }
variable "tags" { type = map(string) default = {} }
