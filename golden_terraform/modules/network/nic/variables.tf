variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "ip_config_name" { type = string default = "ipconfig1" }
variable "subnet_id" { type = string }
variable "public_ip_id" { type = string default = null }
variable "private_ip_allocation" { type = string default = "Dynamic" }
variable "tags" { type = map(string) default = {} }
