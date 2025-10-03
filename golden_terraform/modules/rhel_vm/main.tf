resource "azurerm_linux_virtual_machine" "this" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  network_interface_ids = [var.network_interface_id]
  availability_zone     = var.availability_zone
  availability_set_id   = var.availability_set_id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.os_disk_size_gb
  }

  dynamic "data_disk" {
    for_each = var.data_disks
    content {
      lun            = data_disk.value.lun
      disk_size_gb   = data_disk.value.disk_size_gb
      caching        = data_disk.value.caching
      create_option  = data_disk.value.create_option
    }
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "log_analytics" {
  count               = var.enable_log_analytics_extension && var.log_analytics_workspace_id != "" ? 1 : 0
  name                = "OmsAgentForLinux"
  virtual_machine_id  = azurerm_linux_virtual_machine.this.id
  publisher           = "Microsoft.EnterpriseCloud.Monitoring"
  type                = "OmsAgentForLinux"
  type_handler_version = "1.13"

  settings = jsonencode({
    workspaceId = var.log_analytics_workspace_id
  })
}

resource "azurerm_virtual_machine_extension" "custom_script" {
  count               = length(var.custom_script_extension_settings) > 0 ? 1 : 0
  name                = "CustomScriptExtension"
  virtual_machine_id  = azurerm_linux_virtual_machine.this.id
  publisher           = "Microsoft.Azure.Extensions"
  type                = "CustomScript"
  type_handler_version = "2.1"

  settings = jsonencode(var.custom_script_extension_settings)
}
