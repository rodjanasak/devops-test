output "computerNames" {
  description = "The PostgreSQL server Name"
  value       = module.postgresql.server_name
}

output "subscription_name" {
  value = data.azurerm_subscription.current.display_name
}

output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}

output "instance_name" {
  description = "The Name of the PostgreSQL server"
  value       = module.postgresql.server_name
}

output "fqdn" {
  description = "The fully qualified domain name (FQDN) of the PostgreSQL server"
  value       = "${module.postgresql.server_name}.privatelink.postgres.database.azure.com"
}

output "ipAddress" {
  description = "The private IP address of the PostgreSQL server"
  value       = module.private_ep.private_ip
}
output "operatingSystem" {
  value = var.operatingSystem
}
output "install_date" {
  value = local.timestamp
}
output "install_status" {
  value = "1"
}
output "delivery_date" {
  value = local.timestamp
}
output "application_name" {
  description = "The name of the PostgreSQL server"
  value       = var.applicationName
}
output "service_name" {
  description = "Service name in ITOM"
  value       = "PostgreSQL on Azure"
}
output "debtor_number" {
  value = var.debtor_number
}
output "cost_center" {
  value = var.cost_center
}
output "environment_type" {
  value = lookup(var.environment_mapping, var.environment)
}
output "db_instance_region" {
  value = lookup(var.full_name_location_mapping, var.location)
}

output "serverOwner" {
  value = var.owned_by
}
output "serverClass" {
  value = var.serverClass
}
output "location" {
  value = lookup(var.full_name_location_mapping, var.location)
}
output "assignmentGroup" {
  value = var.assignment_group
}
output "dataClassification" {
  value = var.eu_request_data_classification
}
output "installationsource_middleware" {
  value = var.installationsource_middleware
}
output "retired_date" {
  value = ""
}
output "pg_username" {
  value = "${var.administrator_login}@${module.postgresql.server_name}"
}

output "logical_datacenter_name" {
  value = lookup(var.full_name_location_mapping, var.location)
}

output "logical_datacenter_class" {
  value = var.logical_datacenter_class
}

output "tcp_port" {
  value = "5432"
}

output "instance_resource_id" {
  description = "The resource id of the PostgreSQL server"
  value       = module.postgresql.server_id
}

output "resource_group_id" {
  description = "Get resource_group id of PostgreSQL server"
  value       = data.azurerm_resources.rgpsql.id
}

output "object_id" {
  description = "Get object id of PostgreSQL server"
  value       = module.postgresql.server_id
}

output "EDR_Class" {
  value = var.edr_class
}

output "DRC_Class" {
  value = local.drc_class_map
}

## DR
output "dr_instance_name" {
  description = "The name of the DR PostgreSQL server"
  value       = var.edr_class == "EDR_3" ? join("", module.postgresql_dr.*.server_name) : null
}

output "dr_fqdn" {
  description = "The fully qualified domain name (FQDN) of the DR PostgreSQL server"
  value       = var.edr_class == "EDR_3" ? "${join("", module.postgresql_dr.*.server_name)}.privatelink.postgres.database.azure.com" : null
}

output "dr_ipAddress" {
  description = "The private IP address of the PostgreSQL server"
  value       = var.edr_class == "EDR_3" ? module.dr_private_ep.0.private_ip : null
}

output "dr_location" {
  description = "The private IP address of the PostgreSQL server"
  value       = var.edr_class == "EDR_3" ? lookup(var.full_name_location_mapping, var.dr_location) : null
}

output "dr_object_id" {
  description = "The resource id of the PostgreSQL server"
  value       = var.edr_class == "EDR_3" ? module.postgresql_dr.0.server_id : null
}

