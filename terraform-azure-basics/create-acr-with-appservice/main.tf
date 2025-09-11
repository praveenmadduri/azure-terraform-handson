provider "azurerm" {
  features {}
}

locals {
  regions = ["eastus", "westeurope"]
}

resource "random_id" "acr" {
  byte_length = 3
}

# Resource Groups per region
resource "azurerm_resource_group" "main" {
  for_each = toset(local.regions)
  name     = "rg-acr-appsvc-${each.key}"
  location = each.key
}

# Virtual Networks per region
resource "azurerm_virtual_network" "main" {
  for_each            = toset(local.regions)
  name                = "vnet-${each.key}"
  address_space       = ["10.${100 + index(local.regions, each.key)}.0.0/16"]
  location            = each.key
  resource_group_name = azurerm_resource_group.main[each.key].name
}

# VNet Peering (full mesh for 2 regions)
resource "azurerm_virtual_network_peering" "peering" {
  for_each = {
    for i, region in local.regions : "${region}-to-${local.regions[1 - i]}" => {
      from_region = region
      to_region   = local.regions[1 - i]
    }
  }
  name                      = "peer-${each.value.from_region}-to-${each.value.to_region}"
  resource_group_name       = azurerm_resource_group.main[each.value.from_region].name
  virtual_network_name      = azurerm_virtual_network.main[each.value.from_region].name
  remote_virtual_network_id = azurerm_virtual_network.main[each.value.to_region].id
  allow_forwarded_traffic   = true
  allow_virtual_network_access = true
}

# Subnet for App Service
resource "azurerm_subnet" "appsvc" {
  for_each             = toset(local.regions)
  name                 = "appsvc-subnet"
  resource_group_name  = azurerm_resource_group.main[each.key].name
  virtual_network_name = azurerm_virtual_network.main[each.key].name
  address_prefixes     = ["10.${100 + index(local.regions, each.key)}.1.0/24"]
  service_endpoints    = ["Microsoft.Web"]
}

# Azure Container Registry (ACR) in primary region
resource "azurerm_container_registry" "acr" {
  name                = "multiacr${random_id.acr.hex}"
  resource_group_name = azurerm_resource_group.main[local.regions[0]].name
  location            = local.regions[0]
  sku                 = "Premium"
  admin_enabled       = true
}

# ACR Geo-Replication to secondary regions
resource "azurerm_container_registry_replication" "acr_replication" {
  for_each            = toset(slice(local.regions, 1, length(local.regions)))
  name                = "acr-repl-${each.key}"
  registry_name       = azurerm_container_registry.acr.name
  resource_group_name = azurerm_resource_group.main[local.regions[0]].name
  location            = each.key
}

# App Service Plan and Web App per region
resource "azurerm_app_service_plan" "plan" {
  for_each            = toset(local.regions)
  name                = "asp-${each.key}"
  location            = each.key
  resource_group_name = azurerm_resource_group.main[each.key].name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  for_each                = toset(local.regions)
  name                    = "appsvc-${each.key}-${random_id.acr.hex}"
  location                = each.key
  resource_group_name     = azurerm_resource_group.main[each.key].name
  app_service_plan_id     = azurerm_app_service_plan.plan[each.key].id
  https_only              = true

  site_config {
    linux_fx_version      = "DOCKER|hello-world"
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${azurerm_container_registry.acr.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.acr.admin_password
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "app_service_urls" {
  value = { for k, v in azurerm_app_service.app : k => v.default_site_hostname }
}