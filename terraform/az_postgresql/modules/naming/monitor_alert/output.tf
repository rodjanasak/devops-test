
output "monitor_alert" {
  value = "monitor-${var.environment}-${var.location_shortcut}-${var.service}"
}
