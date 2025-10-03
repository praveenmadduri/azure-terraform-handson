variable "resource_name" {
  description = "Name of the resource for diagnostics"
  type        = string
}

variable "resource_id" {
  description = "Azure Resource ID to monitor"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace Resource ID"
  type        = string
}

variable "logs" {
  description = "List of log categories and enablement"
  type = list(object({
    category          = string
    enabled           = bool
    retention_enabled = optional(bool)
    retention_days    = optional(number)
  }))
  default = [
    { category = "Administrative", enabled = true },
    { category = "Security", enabled = true },
    { category = "ServiceHealth", enabled = true },
    { category = "Alert", enabled = true },
    { category = "Recommendation", enabled = true },
    { category = "Policy", enabled = true },
    { category = "Autoscale", enabled = true },
    { category = "ResourceHealth", enabled = true }
  ]
}

variable "metrics" {
  description = "List of metric categories and enablement"
  type = list(object({
    category          = string
    enabled           = bool
    retention_enabled = optional(bool)
    retention_days    = optional(number)
  }))
  default = [
    { category = "AllMetrics", enabled = true }
  ]
}
