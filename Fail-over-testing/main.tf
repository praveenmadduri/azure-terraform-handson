variable "regions" {
  default = ["eastus", "westus"]
}

resource "azurerm_resource_group" "main" {
  for_each = toset(var.regions)

  name     = "rg-${each.key}"
  location = each.key
}

resource "azurerm_virtual_network" "vnet" {
  for_each = toset(var.regions)

  name                = "vnet-${each.key}"
  address_space       = ["10.${count.index}.0.0/16"]
  location            = each.key
  resource_group_name = azurerm_resource_group.main[each.key].name
}