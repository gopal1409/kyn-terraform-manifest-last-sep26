/*resource "azurerm_public_ip" "web_vm_publicip" {
  for_each = var.instance #default value web1 and web2
  name = "${local.name_prefix}-${var.resource_group_name}-${each.key}-public-ip" #here i ll put each.key so that publicip will be create with unique name 
  #this vnet need location and resource group
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.project_tags
  #when we are creating the public ip that time i am passing zone
  #in the zone i have put each.value for_each varaibles each.value will get all the values
  zones = [each.value.availability_zone] #this will create the public ip in different az
  #when the public ip will be created it will be created in az1 az2
}
/*
output "public_ip_vm" {
  value = azurerm_public_ip.web_vm_publicip.ip_address
}*/
