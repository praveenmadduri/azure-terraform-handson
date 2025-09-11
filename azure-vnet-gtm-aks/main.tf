provider "azurerm" {
  features {}
}

# Variables
variable "regions" {
  description = "List of Azure regions to deploy resources"
  default     = ["eastus", "westus"]
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "multi-region-rg"
}

variable "storage_account_name" {
  description = "Name of the Azure Storage account for the backend"
}

variable "storage_container_name" {
  description = "Name of the Azure Storage container for the backend"
}

variable "terraform_state_key" {
  description = "Key (file name) for the Terraform state file"
  default     = "terraform.tfstate"
}

# Resource Group for Backend Storage
resource "azurerm_resource_group" "backend" {
  name     = "${var.resource_group_name}-backend"
  location = var.regions[0]
}

# Storage Account for Terraform Backend
resource "azurerm_storage_account" "backend" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.backend.name
  location                 = azurerm_resource_group.backend.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage Container for Terraform State
resource "azurerm_storage_container" "backend" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.backend.name
  container_access_type = "private"
}

# Terraform Backend Configuration
terraform {
  backend "azurerm" {
    resource_group_name  = azurerm_resource_group.backend.name
    storage_account_name = azurerm_storage_account.backend.name
    container_name       = azurerm_storage_container.backend.name
    key                  = var.terraform_state_key
  }
}

# Main Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.regions[0]
}

# Example Resource (Virtual Network)
resource "azurerm_virtual_network" "vnet" {
  for_each = toset(var.regions)

  name                = "vnet-${each.key}"
  address_space       = ["10.${count.index}.0.0/16"]
  location            = each.key
  resource_group_name = azurerm_resource_group.main.name
}