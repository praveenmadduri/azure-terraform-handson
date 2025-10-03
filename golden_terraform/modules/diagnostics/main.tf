resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "${var.resource_name}-diag"
  target_resource_id         = var.resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = var.logs
    content {
      category = log.value.category
      enabled  = log.value.enabled
      retention_policy {
        enabled = lookup(log.value, "retention_enabled", false)
        days    = lookup(log.value, "retention_days", 0)
      }
    }
  }

  dynamic "metric" {
    for_each = var.metrics
    content {
      category = metric.value.category
      enabled  = metric.value.enabled
      retention_policy {
        enabled = lookup(metric.value, "retention_enabled", false)
        days    = lookup(metric.value, "retention_days", 0)
      }
    }
  }
}
