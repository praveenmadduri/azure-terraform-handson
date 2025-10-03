variable "name" {}
variable "address_space" { type = list(string) }
variable "location" {}
variable "resource_group_name" {}
variable "dns_servers" { default = [] }
variable "tags" { default = {} }
variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}
