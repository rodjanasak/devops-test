output "resource_group_id" {
  description = "Get resource_group id of PostgreSQL server"
  value       = module.resourcegroup[*].id
}