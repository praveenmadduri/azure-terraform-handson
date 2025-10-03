resource "azurerm_key_vault" "this" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  soft_delete_enabled         = true
  purge_protection_enabled    = false
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id
    key_permissions = [
      "get",
      "list",
      "create",
      "delete",
      "update",
      "import",
      "backup",
      "restore",
      "recover"
    ]
    secret_permissions = [
      "get",
      "list",
      "set",
      "delete",
      "backup",
      "restore",
      "recover"
    ]
  }
  tags = var.tags
}
