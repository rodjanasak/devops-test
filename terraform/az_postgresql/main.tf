# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.61.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
  }
}


locals {
  network_rgp          = var.network_rgp
  vnet_name            = var.vnet_name
  subnet_name          = var.subnet_name
  dr_network_rgp       = var.dr_network_rgp
  dr_vnet_name         = var.dr_vnet_name
  dr_subnet_name       = var.dr_subnet_name
  project_name         = "hcpsql"
  rg_location          = "westeurope"
  location_shortcut    = lookup(var.location_mapping, var.location)
  dr_location_shortcut = lookup(var.location_mapping, var.dr_location)
  timestamp            = formatdate("MM/DD/YYYY hh:mm AA", timestamp())
  drc_class_map        = lookup(var.edr_mapping, var.edr_class)
  geo_redundant_backup = lookup(var.edr_class_geo_redundant_mapping, var.edr_class)
}

resource "null_resource" "pre" {
  provisioner "local-exec" {
    command = <<EOH
        apk update && \
        apk add bash py3-pip && \
        apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python3-dev make cargo && \
        python3 -m venv prod && \
        . prod/bin/activate && \
        python3 -m pip install --upgrade pip setuptools wheel  && \
        pip3 install --extra-index-url https://azcliprod.blob.core.windows.net/beta/simple/ azure-cli && \
        az login --service-principal \
        --username $ARM_CLIENT_ID  \
        --password $ARM_CLIENT_SECRET \
        --tenant $ARM_TENANT_ID  && \
        az account set --subscription $ARM_SUBSCRIPTION_ID && \
        az network vnet subnet update \ 
        --disable-private-endpoint-network-policies true \
        --name ${local.subnet_name} \ 
        --resource-group ${local.network_rgp} \ 
        --vnet-name ${local.vnet_name} \ 
        EOH
  }
}


module "resourcegroup" {
  count             = var.rg_exist == "no" ? 1 : 0
  source            = "./modules/resourcegroup"
  location          = local.rg_location
  location_shortcut = lookup(var.location_mapping, local.rg_location)
  service           = local.project_name

  tags = {
    "snow.serviceId"     = "postgres",
    "snow.dbaas.orderId" = var.snowOrderId,
    "postgres.rg.env"    = var.environment == "p" ? "Prod" : "Non-prod",
    "postgres.rg.oeName" = var.oe_name,
    "postgres.rg.owner"  = var.owned_by
  }
  depends_on = [
    null_resource.pre
  ]
}

data "azurerm_resources" "rgpsql" {
  name = var.rg_name
}

module "postgresql" {
  source = "./modules/postgresql"

  service           = var.applicationName
  location_shortcut = local.location_shortcut
  environment       = var.environment

  location       = var.location
  resource_group = data.azurerm_resources.rgpsql.name

  administrator_login          = var.administrator_login
  administrator_login_password = var.pg_password

  sku_name   = "${var.sku_tier}_${var.sku_family}_${var.sku_vcore}"
  pgversion  = var.pgversion
  storage_mb = var.storage_mb

  backup_retention_days = var.backup_retention_days
  auto_grow             = var.auto_grow
  geo_redundant_backup  = local.geo_redundant_backup

  tags = {
    "snow.serviceId"               = "postgres",
    "postgres.oeName"              = var.oe_name,
    "postgres.serverName"          = "psql-${var.environment}-${lookup(var.location_mapping, var.location)}-${var.applicationName}",
    "postgres.assignmentGroup"     = var.assignment_group,
    "postgres.debtorNumber"        = var.debtor_number,
    "postgres.costCenter"          = var.cost_center,
    "postgres.platformType"        = var.platformType,
    "postgres.DRCClass"            = local.drc_class_map,
    "postgres.owner"               = var.owned_by,
    "postgres.dataClassification"  = var.eu_request_data_classification,
    "postgres.retiredDate"         = "",
    "postgres.projectName"         = var.applicationName,
    "postgres.env"                 = var.environment == "p" ? "Prod" : "Non-prod",
    "postgres.version"             = var.pgversion,
    "postgres.installDate"         = local.timestamp,
    "postgres.configureType"       = lookup(var.skutier_mapping, var.sku_tier),
    "postgres.rg"                  = data.azurerm_resources.rgpsql.name,
    "postgres.backupType"          = local.geo_redundant_backup == "false" ? "Locally Redundant" : "Geographically Redundant",
    "postgres.backupRetention"     = var.backup_retention_days,
    "postgres.consumption.storage" = var.storage_mb
  }

  depends_on = [
    module.resourcegroup
  ]
}

module "private_ep" {
  source = "./modules/network/private_ep"

  environment       = var.environment
  location_shortcut = local.location_shortcut
  service           = var.applicationName
  role              = var.role
  # pid               = var.pid

  location               = var.location
  resource_group         = data.azurerm_resources.rgpsql.name
  postgresql_server      = module.postgresql.server_id
  postgresql_server_name = module.postgresql.server_name
  subnet_id              = data.azurerm_subnet.get.id
  vnet_id                = data.azurerm_virtual_network.avn.id
  network_resource_group = data.azurerm_virtual_network.avn.resource_group_name

  tags = {
    "snow.serviceId"                        = "postgres",
    "postgres.endpoint.oeName"              = var.oe_name,
    "postgres.endpoint.debtorNumber"        = var.debtor_number,
    "postgres.endpoint.costCenter"          = var.cost_center,
    "postgres.endpoint.subscription"        = data.azurerm_subscription.current.subscription_id,
    "postgres.endpoint.owner"               = var.owned_by,
    "postgres.endpoint.assignmentGroup"     = var.assignment_group,
    "postgres.endpoint.projectName"         = var.applicationName,
    "postgres.endpoint.name"                = module.private_ep.endpoint_name,
    "postgres.endpoint.env"                 = var.environment == "p" ? "Prod" : "Non-prod",
    "postgres.endpoint.rg"                  = data.azurerm_resources.rgpsql.name,
    "postgres.endpoint.privateLinkResource" = "psql-${var.environment}-${lookup(var.location_mapping, var.location)}-${var.applicationName}.postgres.database.azure.com",
    "postgres.endpoint.vnet"                = local.vnet_name,
    "postgres.endpoint.subnet"              = local.subnet_name,
    "postgres.endpoint.installDate"         = local.timestamp,
    "postgres.endpoint.retiredDate"         = ""
  }

  depends_on = [
    module.postgresql
  ]
}


module "postgresql_dr" {
  count             = var.edr_class == "EDR_3" ? 1 : 0
  source            = "./modules/postgresql_dr"
  service           = var.applicationName
  location_shortcut = local.dr_location_shortcut

  location       = var.dr_location
  resource_group = data.azurerm_resources.rgpsql.name

  administrator_login          = var.administrator_login
  administrator_login_password = var.pg_password

  sku_name   = "${var.sku_tier}_${var.sku_family}_${var.sku_vcore}"
  pgversion  = var.pgversion
  storage_mb = var.storage_mb

  backup_retention_days = var.backup_retention_days
  auto_grow             = var.auto_grow
  geo_redundant_backup  = local.geo_redundant_backup

  create_mode          = "Replica"
  postgresql_master_id = module.postgresql.server_id

  dr_network_rgp = local.dr_network_rgp
  dr_vnet_name   = local.dr_vnet_name
  dr_subnet_name = local.dr_subnet_name

  tags = {
    "snow.serviceId"               = "postgres",
    "snow.dbaas.orderId"           = var.snowOrderId,
    "postgres.oeName"              = var.oe_name,
    "postgres.serverName"          = "psql-dr-${lookup(var.location_mapping, var.location)}-${var.applicationName}.postgres.database.azure.com",
    "postgres.assignmentGroup"     = var.assignment_group,
    "postgres.debtorNumber"        = var.debtor_number,
    "postgres.costCenter"          = var.cost_center,
    "postgres.platformType"        = var.platformType,
    "postgres.DRCClass"            = local.drc_class_map,
    "postgres.owner"               = var.owned_by,
    "postgres.dataClassification"  = var.eu_request_data_classification,
    "postgres.retiredDate"         = "",
    "postgres.projectName"         = var.applicationName,
    "postgres.env"                 = "DR",
    "postgres.version"             = var.pgversion,
    "postgres.installDate"         = local.timestamp,
    "postgres.configureType"       = lookup(var.skutier_mapping, var.sku_tier),
    "postgres.rg"                  = data.azurerm_resources.rgpsql.name,
    "postgres.backupType"          = local.geo_redundant_backup == "false" ? "Locally Redundant" : "Geographically Redundant",
    "postgres.backupRetention"     = var.backup_retention_days,
    "postgres.consumption.storage" = var.storage_mb
  }

  depends_on = [
    module.postgresql
  ]

}

module "dr_private_ep" {
  count                  = var.edr_class == "EDR_3" ? 1 : 0
  source                 = "./modules/network/private_ep"
  environment            = "dr"
  location_shortcut      = local.dr_location_shortcut
  service                = var.applicationName
  role                   = var.role
  location               = var.dr_location
  resource_group         = data.azurerm_resources.rgpsql.name
  postgresql_server      = module.postgresql_dr.0.server_id
  postgresql_server_name = module.postgresql_dr.0.server_name

  subnet_id              = module.postgresql_dr.0.subnet_id
  vnet_id                = module.postgresql_dr.0.vnet_id
  network_resource_group = module.postgresql_dr.0.network_resource_group


  tags = {
    "snow.serviceId"                        = "postgres",
    "postgres.endpoint.oeName"              = var.oe_name,
    "postgres.endpoint.debtorNumber"        = var.debtor_number,
    "postgres.endpoint.costCenter"          = var.cost_center,
    "postgres.endpoint.subscription"        = data.azurerm_subscription.current.subscription_id,
    "postgres.endpoint.owner"               = var.owned_by,
    "postgres.endpoint.assignmentGroup"     = var.assignment_group,
    "postgres.endpoint.projectName"         = var.applicationName,
    "postgres.endpoint.name"                = module.dr_private_ep.0.endpoint_name,
    "postgres.endpoint.env"                 = var.environment == "p" ? "Prod" : "Non-prod",
    "postgres.endpoint.rg"                  = var.rg_exist == "yes" ? data.azurerm_resources.rgpsql.name : module.resourcegroup.resource_group,
    "postgres.endpoint.privateLinkResource" = "psql-dr-${lookup(var.location_mapping, var.location)}-${var.applicationName}.postgres.database.azure.com",
    "postgres.endpoint.vnet"                = local.dr_vnet_name,
    "postgres.endpoint.subnet"              = local.dr_subnet_name,
    "postgres.endpoint.installDate"         = local.timestamp,
    "postgres.endpoint.retiredDate"         = ""
  }

  depends_on = [
    module.postgresql_dr
  ]
}

resource "random_id" "unique" {
  byte_length = 6
}
resource "azurerm_monitor_action_group" "main" {
  count = var.rg_exist == "no" ? 1 : 0

  name                = "DBaSS Postgresql-${lower(random_id.unique.id)}"
  resource_group_name = data.azurerm_resources.rgpsql.name
  short_name          = "psql-dbass"
  email_receiver {
    name          = "DBaaS_Admin"
    email_address = "dbaas.operations@allianz.com"
  }
  email_receiver {
    name          = "GCCC_Team"
    email_address = "gccc@allianz.com"
  }
  depends_on = [
    module.postgresql
  ]
}
resource "azurerm_monitor_activity_log_alert" "main" {
  count               = var.rg_exist == "no" ? 1 : 0
  name                = "Planned Maintenance - PostgreSQL"
  resource_group_name = data.azurerm_resources.rgpsql.name
  scopes              = [data.azurerm_subscription.current.id]
  description         = "This alert will monitor Planned Maintenance and send alert to DBaaS and GCCC Team."
  criteria {
    category = "ServiceHealth"
    service_health {
      events    = ["Maintenance"]
      locations = ["Global"]
      services  = ["Azure Database for PostgreSQL"]
    }
  }
  action {
    action_group_id = azurerm_monitor_action_group.main[count.index].id
  }
  depends_on = [
    module.postgresql
  ]
}
