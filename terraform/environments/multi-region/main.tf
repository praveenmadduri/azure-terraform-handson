provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

# === EAST US ===
module "rg_eastus" {
  source   = "../../modules/resource_group"
  name     = "rg-eastus"
  location = "East US"
}

module "vnet_eastus" {
  source              = "../../modules/network/vnet"
  name                = "vnet-eastus"
  address_space       = ["10.1.0.0/16"]
  location            = "East US"
  resource_group_name = module.rg_eastus.name

  subnets = [
    {
      name             = "subnet-eastus"
      address_prefixes = ["10.1.1.0/24"]
    }
  ]
}

module "vm_eastus" {
  source              = "../../modules/rhel_vm"
  name                = "rhel-eastus"
  location            = "East US"
  resource_group_name = module.rg_eastus.name
  subnet_id           = module.vnet_eastus.subnet_ids["subnet-eastus"]
  admin_username      = "adminuser"
  admin_password      = "P@ssword123!"
  depends_on          = [module.vnet_eastus]
}

module "log_eastus" {
  source              = "../../modules/log_analytics"
  name                = "log-eastus"
  location            = "East US"
  resource_group_name = module.rg_eastus.name
}

module "kv_eastus" {
  source              = "../../modules/key_vault"
  name                = "kv-eastus"
  location            = "East US"
  resource_group_name = module.rg_eastus.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

# === CENTRAL US ===
module "rg_centralus" {
  source   = "../../modules/resource_group"
  name     = "rg-centralus"
  location = "Central US"
}

module "vnet_centralus" {
  source              = "../../modules/network/vnet"
  name                = "vnet-centralus"
  address_space       = ["10.2.0.0/16"]
  location            = "Central US"
  resource_group_name = module.rg_centralus.name

  subnets = [
    {
      name             = "subnet-centralus"
      address_prefixes = ["10.2.1.0/24"]
    }
  ]
}

module "vm_centralus" {
  source              = "../../modules/rhel_vm"
  name                = "rhel-centralus"
  location            = "Central US"
  resource_group_name = module.rg_centralus.name
  subnet_id           = module.vnet_centralus.subnet_ids["subnet-centralus"]
  admin_username      = "adminuser"
  admin_password      = "P@ssword123!"
  depends_on          = [module.vnet_centralus]
}

module "log_centralus" {
  source              = "../../modules/log_analytics"
  name                = "log-centralus"
  location            = "Central US"
  resource_group_name = module.rg_centralus.name
}

module "kv_centralus" {
  source              = "../../modules/key_vault"
  name                = "kv-centralus"
  location            = "Central US"
  resource_group_name = module.rg_centralus.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

# === DNS Shared Component ===
module "dns_zone" {
  source              = "../../modules/private_dns"
  name                = "internal.contoso.com"
  resource_group_name = module.rg_eastus.name
}
