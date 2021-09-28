module "naming" {
  source            = "../naming/resourcegroup"
  project           = var.project
  location_shortcut = var.location_shortcut
}


resource "azurerm_resource_group" "rgp" {
  name     = module.naming.resource_group
  location = var.location
  tags     = var.tags
}
