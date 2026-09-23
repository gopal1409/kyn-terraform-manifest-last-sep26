resource "azurerm_network_interface" "web_nic" {
  name = "${local.name_prefix}-${var.resource_group_name}-nic"
  #this vnet need location and resource group
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
 #nic is something called as ip configuration
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web-subnet.id #this will allocate private ip 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id =  azurerm_public_ip.web_vm_publicip.id
  }
}