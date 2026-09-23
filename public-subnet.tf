resource "azurerm_subnet" "web-subnet" {
  name                 = "${local.name_prefix}-${var.resource_group_name}-web-subnet"
  resource_group_name  = azurerm_resource_group.my-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_subnet_address

}