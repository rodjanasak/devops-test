output "private_endpoint" {
  # value = "pep-${var.environment}-${var.location_shortcut}-${var.service}-${var.role}-${var.pid}"
  value = "pep-${var.environment}-${var.location_shortcut}-${var.service}-${var.role}"
}
