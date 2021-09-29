module "naming" {
  source            = "../naming/resourcegroup"
  service           = var.service
  location_shortcut = var.location_shortcut
  # rid           = var.rid
}


resource "azurerm_resource_group" "rgp" {
  name     = module.naming.resource_group
  location = var.location
  tags     = var.tags
}
