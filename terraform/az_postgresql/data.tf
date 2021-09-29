
data "azurerm_subscription" "current" {
}


data "azurerm_virtual_network" "avn" {
  name                = local.vnet_name
  resource_group_name = local.network_rgp
}

data "azurerm_subnet" "get" {
  name                 = local.subnet_name
  virtual_network_name = data.azurerm_virtual_network.avn.name
  resource_group_name  = local.network_rgp

  #enforce_private_link_endpoint_network_policies = true
}

