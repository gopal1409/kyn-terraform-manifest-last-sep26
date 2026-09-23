resource "azurerm_public_ip" "web_vm_publicip" {
  name = "${local.name_prefix}-${var.resource_group_name}-public-ip"
  #this vnet need location and resource group
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.project_tags
}

output "public_ip_vm" {
  value = azurerm_public_ip.web_vm_publicip.ip_address
}