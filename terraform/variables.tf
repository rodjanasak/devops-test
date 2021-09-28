## General Info ##
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

variable "rg_name" {
  description = "default resource group name"
  default     = "rg-sea1-oozou_rodjanasak"
}

variable "rg_location" {
  description = "default resource group location"
  default     = "southeastasia"
}

variable "project_name" {
  description = "project_name will use for resource group name."
  default     = "oozou_rodjanasak"
}

variable "owned_by" {
  description = "Service owner."
  default     = "rodjanasak"
}

variable "environment" {
  description = "Environment d (Development), s (Staging), i (Integration), p (Production)."
  default     = "d"
}