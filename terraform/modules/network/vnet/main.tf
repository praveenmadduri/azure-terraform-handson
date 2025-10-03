resource "azurerm_virtual_network" "this" {
  name                = var.name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  for_each = { for s in var.subnets : s.name => s }

  name                 = each.value.name
  address_prefixes     = each.value.address_prefixes
  virtual_network_name = azurerm_virtual_network.this.name
  resource_group_name  = var.resource_group_name
}

output "subnet_ids" {
  value = {
    for k, s in azurerm_subnet.subnet : k => s.id
  }
}
