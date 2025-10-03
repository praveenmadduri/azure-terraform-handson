variable "name" { type = string }
variable "address_space" { type = list(string) }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) default = {} }
variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
    service_endpoints= optional(list(string))
    delegation       = optional(object({
      name    = string
      service = string
    }))
  }))
}
