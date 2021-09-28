# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.78.0"
    }
  }
}

locals {
  rg_location_shortcut = lookup(var.location_mapping, var.rg_location)
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "d16dbeef-b692-43a7-8469-6e23101f4c40"
  client_id       = "1a7cf6d1-7bfb-4b50-af1e-5359b99e78ff"
  client_secret   = "nmgjI7tU5mlWtS12dJq.MePrebriGZe35N"
  tenant_id       = "87211dbe-511a-4cb0-a4d7-5f0921eadb1f"
}

module "resourcegroup" {
  source            = "./modules/resourcegroup"
  location          = var.rg_location
  location_shortcut = local.rg_location_shortcut
  project           = var.project_name

  tags = {
    "rg.serviceId" = "Azure Web App",
    "rg.env"       = var.environment == "p" ? "Prod" : "Non-prod",
    "rg.owner"     = var.owned_by
  }
}

