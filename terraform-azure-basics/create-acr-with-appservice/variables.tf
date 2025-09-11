variable "regions" {
  description = "List of Azure regions for multi-region deployment"
  type        = list(string)
  default     = ["eastus", "westeurope"]
}