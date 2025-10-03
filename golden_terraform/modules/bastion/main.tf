resource "azurerm_public_ip" "bastion_ip" {
  name                = "${var.name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_bastion_host" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                 = "${var.name}-ip-config"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }

  tags = var.tags
}
