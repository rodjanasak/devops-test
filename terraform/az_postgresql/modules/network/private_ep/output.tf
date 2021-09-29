output "private_ip" {
  description = "The private IP address of the PostgreSQL server"
  value       = [data.azurerm_private_endpoint_connection.plinkconnection.private_service_connection.0.private_ip_address]
}

output "endpoint_name" {
  value = module.naming.private_endpoint
}
