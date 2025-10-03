variable "name" {
  description = "The name of the route table"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "routes" {
  description = "Map of routes with keys as route names and values as objects with address_prefix and next_hop_type"
  type = map(object({
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = {}
}

variable "subnet_ids" {
  description = "Map of subnet IDs to associate with this route table"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
