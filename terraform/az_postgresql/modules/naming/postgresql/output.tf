output "postgresql" {
  #value = "psql-${var.environment}-${var.location_shortcut}-${var.service}-${var.pid}"
  value = "psql-${var.environment}-${var.location_shortcut}-${var.service}"
}
