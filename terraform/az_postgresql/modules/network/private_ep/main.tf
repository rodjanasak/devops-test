module "naming" {
  source            = "../../naming/network/private_ep"
  environment       = var.environment
  location_shortcut = var.location_shortcut
  service           = var.service
  role              = var.role
  # pid               = var.pid
}

resource "azurerm_private_endpoint" "plink" {
  name                = module.naming.private_endpoint
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = module.naming.private_endpoint
    private_connection_resource_id = var.postgresql_server
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  tags = var.tags

}


data "azurerm_private_endpoint_connection" "plinkconnection" {
  name                = azurerm_private_endpoint.plink.name
  resource_group_name = azurerm_private_endpoint.plink.resource_group_name
}

