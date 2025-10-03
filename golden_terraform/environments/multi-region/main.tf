terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# RG in East US
module "rg_eastus" {
  source   = "../../modules/resource_group"
  name     = var.resource_group_eastus
  location = var.location_eastus
  tags     = var.tags
}

# RG in West US
module "rg_westus" {
  source   = "../../modules/resource_group"
  name     = var.resource_group_westus
  location = var.location_westus
  tags     = var.tags
}

# VNet in East US
module "vnet_eastus" {
  source              = "../../modules/network/vnet"
  name                = var.vnet_name_eastus
  location            = module.rg_eastus.location
  resource_group_name = module.rg_eastus.name
  address_space       = var.vnet_address_space_eastus
  subnets             = var.vnet_subnets_eastus
  tags                = var.tags
}

# NSG in East US
module "nsg_eastus" {
  source              = "../../modules/network/nsg"
  name                = var.nsg_name_eastus
  location            = module.rg_eastus.location
  resource_group_name = module.rg_eastus.name
  security_rules      = var.nsg_security_rules
  tags                = var.tags
}

# Associate NSG to subnet
resource "azurerm_subnet_network_security_group_association" "eastus" {
  subnet_id                 = module.vnet_eastus.subnet_ids["${var.vnet_subnets_eastus[0].name}"]
  network_security_group_id = module.nsg_eastus.id
}

# Public IP in East US
module "public_ip_eastus" {
  source              = "../../modules/network/public_ip"
  name                = var.public_ip_name_eastus
  location            = module.rg_eastus.location
  resource_group_name = module.rg_eastus.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# NIC in East US
module "nic_eastus" {
  source              = "../../modules/network/nic"
  name                = var.nic_name_eastus
  location            = module.rg_eastus.location
  resource_group_name = module.rg_eastus.name
  ip_config_name      = "ipconfig1"
  subnet_id           = module.vnet_eastus.subnet_ids["${var.vnet_subnets_eastus[0].name}"]
  public_ip_id        = module.public_ip_eastus.id
  private_ip_allocation = "Dynamic"
  tags                = var.tags
}

# RHEL VM in East US
module "rhel_vm_eastus" {
  source              = "../../modules/rhel_vm"
  name                = var.vm_name_eastus
  resource_group_name = module.rg_eastus.name
  location            = module.rg_eastus.location
  nic_id              = module.nic_eastus.id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  size                = var.vm_size
  tags                = var.tags
}

# Log Analytics workspace in East US
module "log_analytics_eastus" {
  source              = "../../modules/log_analytics"
  name                = var.log_analytics_name_eastus
  location            = module.rg_eastus.location
  resource_group_name = module.rg_eastus.name
  retention_in_days   = 30
  tags                = var.tags
}

# Key Vault in East US
module "key_vault_eastus" {
  source              = "../../modules/key_vault"
  name                = var.key_vault_name_eastus
  location            = module.rg_eastus.location
  resource_group_name = module.rg_eastus.name
  tenant_id           = var.tenant_id
  object_id           = var.admin_object_id
  tags                = var.tags
}

# Private DNS zone in East US
module "private_dns_eastus" {
  source              = "../../modules/private_dns"
  name                = var.private_dns_zone_name
  resource_group_name = module.rg_eastus.name
  tags                = var.tags
}

# You can replicate similar resources for West US or any other region as needed.
