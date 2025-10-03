subscription_id        = "YOUR_AZURE_SUBSCRIPTION_ID"
tenant_id              = "YOUR_TENANT_ID"
admin_object_id        = "YOUR_AZURE_AD_OBJECT_ID"

resource_group_eastus  = "rg-eastus-golden"
location_eastus        = "eastus"
resource_group_westus  = "rg-westus-golden"
location_westus        = "westus2"

vnet_name_eastus       = "vnet-eastus-golden"
vnet_address_space_eastus = ["10.10.0.0/16"]
vnet_subnets_eastus = [
  {
    name             = "subnet-app"
    address_prefixes = ["10.10.1.0/24"]
  }
]

nsg_name_eastus       = "nsg-eastus-golden"
nsg_security_rules = [
  {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "Allow SSH"
  }
]

public_ip_name_eastus  = "pip-eastus-golden"
nic_name_eastus        = "nic-eastus-golden"
vm_name_eastus         = "rhelvm-eastus-golden"
admin_username         = "azureuser"
admin_password         = "StrongPassword123!" # Change this securely before use
vm_size                = "Standard_B2s"

log_analytics_name_eastus = "loganalytics-eastus-golden"
key_vault_name_eastus     = "kv-eastus-golden"
private_dns_zone_name     = "privatelink.database.windows.net"

tags = {
  environment = "golden"
  owner       = "team"
}
