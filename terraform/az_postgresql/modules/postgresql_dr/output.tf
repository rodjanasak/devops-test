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

output "subnet_id" {
  value = data.azurerm_subnet.dr_subnet.id
}

output "vnet_id" {
  value = data.azurerm_virtual_network.dr_vnet.id
}

output "network_resource_group" {
  value = data.azurerm_virtual_network.dr_vnet.resource_group_name
}

output "vnet_name" {
  value = data.azurerm_virtual_network.dr_vnet.name
}

output "address_prefix" {
  value = data.azurerm_subnet.dr_subnet.address_prefix
}

output "subnet_name" {
  value = data.azurerm_subnet.dr_subnet.name
}


