variable "environment" {
  default = "dr"
}
variable "location_shortcut" {}
variable "service" {}
# variable "pid" {}
variable "location" {}
variable "resource_group" {}
variable "sku_name" {}
variable "storage_mb" {}
variable "backup_retention_days" {}
variable "auto_grow" {}
variable "geo_redundant_backup" {}
variable "administrator_login" {}
variable "administrator_login_password" {}
variable "pgversion" {}
variable "tags" {}
variable "postgresql_master_id" {}
variable "create_mode" {
  default = "Replica"
}
variable "dr_vnet_name" {}
variable "dr_network_rgp" {}
variable "dr_subnet_name" {}
# variable "ft" {}
