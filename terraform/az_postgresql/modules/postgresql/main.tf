module "naming" {
  source            = "../naming/postgresql"
  environment       = var.environment
  location_shortcut = var.location_shortcut
  service           = var.service
  # pid               = var.pid
}

# Create PostgreSQL Server
resource "azurerm_postgresql_server" "psql" {
  name                = module.naming.postgresql
  location            = var.location
  resource_group_name = var.resource_group

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  sku_name   = var.sku_name
  version    = var.pgversion
  storage_mb = var.storage_mb

  backup_retention_days        = var.backup_retention_days
  auto_grow_enabled            = var.auto_grow
  geo_redundant_backup_enabled = var.geo_redundant_backup

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  tags = var.tags
}
