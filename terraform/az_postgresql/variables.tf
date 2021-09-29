## General Info ##
variable "rg_exist" {
  description = "Check whether resource group are exist."
  default     = "yes"
}

variable "default_setting" {
  description = "use resource group default setting ."
  default     = "yes"
}

variable "rg_name" {
  description = "default resource group name"
  default     = "rgp-we1-hcpsql"
}

variable "rg_location" {
  description = "default resource group location"
  default     = "westeurope"
}

variable "ft" {
  default = "yes"
}

variable "name" {
  description = "Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
  default     = "terraform-postgresql"
}

variable "applicationName" {
  description = "application name will use as part of instance name"
  default     = "drc5"

}

variable "role" {
  description = "type of service"
  default     = "psql"
}

variable "rid" {
  description = "Resource group running number"
  default     = "01"
}

variable "pid" {
  description = "PostgreSQL running number"
  default     = "01"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  default     = "westeurope"
}

variable "location_shortcut" {
  description = "Map location to short name."
  default     = "we1"
}

variable "environment" {
  description = "Environment d (Dev), s (Staging), i (Integration), p (Prod)."
  default     = "d"
}


variable "sku_name" {
  description = "Pricing tier. B (Basic), GP (General Purpose), MO (Memory Optimized)."
  default     = "GP_Gen5_2"
}
variable "sku_tier" {
  description = "Pricing tier. B (Basic), GP (General Purpose), MO (Memory Optimized)."
  default     = "GP"
}

variable "skutier_mapping" {
  description = "mapping for sku tier"
  default = {
    "B"  = "Basic",
    "GP" = "General Purpose",
    "MO" = "Memory Optimized"
  }
}

variable "sku_family" {
  description = "CPU family, Gen4 or Gen5."
  default     = "Gen5"
}

variable "sku_vcore" {
  description = "Number of CPU cores (2, 4, 8, 16, 32, 64)."
  default     = "2"
}

variable "storage_mb" {
  description = "Max storage allowed for a server (size in MB)."
  default     = "5120"
}

variable "backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  default     = "7"
}

variable "auto_grow" {
  description = "Enable/Disable auto-growing of the storage. Valid values for this property are Enabled or Disabled."
  default     = false
}

variable "geo_redundant_backup" {
  description = "Enable/Disable Geo-redundant for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier."
  default     = "false"
}

variable "administrator_login" {
  description = "The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created."
  default     = "pgadmin"
}

variable "pg_password" {
  description = "The Password associated with the administrator_login for the PostgreSQL Server."
  default     = "A~p3ex5KMBx5:^&1u=Zd"
}

variable "pgversion" {
  description = "Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, 10, 10.0, and 11."
  default     = "11"
}

variable "environment_mapping" {
  description = "mapping for environment"
  default = {
    "p" = "Production",
    "s" = "Staging",
    "i" = "Integration",
    "u" = "User Acceptance Test",
    "d" = "Development"
  }
}
######################

## Tagging Info ##
variable "snowOrderId" {
  description = "Service Now Request number"
  default     = ""
}

variable "debtor_number" {
  description = "Debtor Number."
  default     = ""
}

variable "cost_center" {
  description = "Cost Center."
  default     = ""
}

variable "owned_by" {
  description = "Service owner."
  default     = ""
}

variable "logical_datacenter_class" {
  description = "Data Center"
  default     = "Azure Datacenter"
}

variable "serverClass" {
  default = "base"
}

variable "assignment_group" {
  default = ""
}

variable "restriction" {
  default = ""
}

variable "eu_request_data_classification" {
  default = "Internal"
}

variable "eu_request_custom_roles" {
  default = ""
}

variable "installationsource_middleware" {
  default = "Azure Native"
}

variable "retired_date" {
  default = ""
}

variable "operatingSystem" {
  default = "Linux"
}

variable "oe_name" {
  default = "Allianz Technology Thailand"
}

variable "subscription_id" {
  default = ""
}

variable "platformType" {
  default = "Single Server"
}
######################

## Alert Metrix Info ##
variable "metric_namespace" {
  default = "Microsoft.DBforPostgreSQL/servers"
}
variable "aggregation" {
  default = "Average"
}
variable "operator" {
  default = "GreaterThan"
}
variable "warn_cpu" {
  default = "70"
}
variable "cri_cpu" {
  default = "80"
}
variable "warn_mem" {
  default = "70"
}
variable "cri_mem" {
  default = "80"
}
variable "warn_storage" {
  default = "70"
}
variable "cri_storage" {
  default = "80"
}
variable "warn_active_con" {
  default = "90"
}
variable "cri_active_con" {
  default = "120"
}
variable "warn_failed_con" {
  default = "5"
}
variable "cri_failed_con" {
  default = "10"
}
variable "warn_log_storage" {
  default = "70"
}
variable "cri_log_storage" {
  default = "80"
}
variable "warn_io" {
  default = "70"
}
variable "cri_io" {
  default = "80"
}
variable "email_dbaas" {
  default = "allianztechnology.th-db-support@allianz.com"
}
######################

## Network Info ##
variable "network_rgp" {
  default = "rgp-d-we1-dbaaspoc-networking"
}

variable "vnet_name" {
  default = "vnet-d-we1-01"
}

variable "subnet_name" {
  default = "sub-d-we1-pubint3-44.142.190.192-27"
}
######################

## DR Info ##
variable "edr_class" {
  default = "EDR_1"
}

variable "drc_class" {
  default = "DRC5"
}

variable "dr_location" {
  description = "Specifies the supported Azure location where the resource exists."
  default     = "australiaeast"
}

variable "dr_location_shortcut" {
  description = "Map location for DR to short name."
  default     = "ae1"
}

variable "dr_network_rgp" {
  default = ""
}

variable "dr_vnet_name" {
  default = ""
}

variable "dr_subnet_name" {
  default = ""
}
######################

## Mapping Info ##
variable "location_mapping" {
  description = "mapping for location"
  default = {
    "australiaeast"      = "ae1",
    "centralus"          = "cu1",
    "eastus"             = "eu1",
    "eastus2"            = "eu2",
    "francecentral"      = "fc1",
    "westeurope"         = "we1",
    "westus"             = "wus1",
    "westus2"            = "wu2",
    "germanywestcentral" = "gwc1",
    "southeastasia"      = "sea1"
  }
}

variable "full_name_location_mapping" {
  description = "Show full name mapping for location"
  default = {
    "australiaeast"      = "Australia",
    "centralus"          = "Central US (Iowa)",
    "eastus"             = "East US",
    "eastus2"            = "East US 2 (Virginia)",
    "francecentral"      = "France Central",
    "westeurope"         = "EU West 1 (Netherlands)",
    "westus"             = "West US",
    "westus2"            = "West US 2 (Washington)"
    "germanywestcentral" = "Germany West (Frankfurt)",
    "southeastasia"      = "SouthEast Asia"
  }
}

variable "edr_mapping" {
  description = "mapping DRC Class with EDR class"
  default = {
    "EDR_3" = "DRC2",
    "EDR_2" = "DRC4",
    "EDR_1" = "DRC5"
  }
}

variable "edr_class_geo_redundant_mapping" {
  description = "mapping for EDR class"
  default = {
    "EDR_3" = "true",
    "EDR_2" = "true",
    "EDR_1" = "false"
  }
}
######################
