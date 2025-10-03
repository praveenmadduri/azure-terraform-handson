variable "name" {
  type        = string
  description = "VM name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "size" {
  type        = string
  description = "VM size"
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "Admin username"
}

variable "admin_ssh_key" {
  type        = string
  description = "Admin SSH public key"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone (optional)"
  default     = null
}

variable "availability_set_id" {
  type        = string
  description = "Availability Set ID (optional)"
  default     = null
}

variable "os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB"
  default     = 30
}

variable "data_disks" {
  type = list(object({
    lun            = number
    disk_size_gb   = number
    caching        = string
    create_option  = string
  }))
  description = "List of data disks"
  default     = []
}

variable "network_interface_id" {
  type        = string
  description = "Network Interface ID"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics Workspace Resource ID"
  default     = ""
}

variable "enable_log_analytics_extension" {
  type        = bool
  description = "Enable Log Analytics VM extension"
  default     = true
}

variable "custom_script_extension_settings" {
  type        = map(string)
  description = "Custom script extension settings"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}
