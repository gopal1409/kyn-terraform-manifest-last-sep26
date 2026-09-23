resource "azurerm_virtual_network" "vnet" {
  name = "${local.name_prefix}-${var.resource_group_name}-vnet"
  #this vnet need location and resource group
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
  address_space       = var.vnet_address_space
  tags                = local.project_tags
}

