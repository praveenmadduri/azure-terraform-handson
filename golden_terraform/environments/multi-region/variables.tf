variable "subscription_id" { type = string }
variable "tenant_id" { type = string }
variable "admin_object_id" { type = string }

variable "resource_group_eastus" { type = string }
variable "location_eastus" { type = string }
variable "resource_group_westus" { type = string }
variable "location_westus" { type = string }

variable "vnet_name_eastus" { type = string }
variable "vnet_address_space_eastus" { type = list(string) }
variable "vnet_subnets_eastus" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "nsg_name_eastus" { type = string }
variable "nsg_security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = optional(string)
  }))
}

variable "public_ip_name_eastus" { type = string }
variable "nic_name_eastus" { type = string }
variable "vm_name_eastus" { type = string }
variable "admin_username" { type = string }
variable "admin_password" { type = string, sensitive = true }
variable "vm_size" { type = string }

variable "log_analytics_name_eastus" { type = string }
variable "key_vault_name_eastus" { type = string }
variable "private_dns_zone_name" { type = string }

variable "tags" { type = map(string) default = {} }
