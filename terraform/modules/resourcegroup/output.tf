output "resource_group" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rgp.name
}

output "id" {
  description = "resourceid"
  value       = azurerm_resource_group.rgp.id
}
