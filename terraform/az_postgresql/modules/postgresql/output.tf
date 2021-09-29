output "server_name" {
  description = "The name of the PostgreSQL server"
  value       = azurerm_postgresql_server.psql.name
}

output "server_fqdn" {
  description = "The fully qualified domain name (FQDN) of the PostgreSQL server"
  value       = azurerm_postgresql_server.psql.fqdn
}

output "server_id" {
  description = "The resource id of the PostgreSQL server"
  value       = azurerm_postgresql_server.psql.id
}

output "administrator_login" {
  value = var.administrator_login
}

output "administrator_login_password" {
  value     = var.administrator_login_password
  sensitive = true
}
