variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "example-resource-group"
}

variable "location" {
  description = "The Azure region where the resource group will be created"
  type        = string
  default     = "East US"
}