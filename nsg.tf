#lets create our own nsg
resource "azurerm_network_security_group" "web_nsg" {
  name = "${local.name_prefix}-${var.resource_group_name}-web-nsg"
  #this vnet need location and resource group
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name

  tags = local.project_tags
}

#attach the nsg with subnet
resource "azurerm_subnet_network_security_group_association" "web_nsg_association" {
  subnet_id                 = azurerm_subnet.web-subnet.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

locals {
  web_nsg_rule = { #web nsg rule is the name 
    "110" : "22",  #expression in key value format key priority value is port number
    "120" : "80",
    "130" : "443"
  }
}
#inside nsg i want to open port 22 80 443
resource "azurerm_network_security_rule" "web_nsg_rule" {
  for_each = local.web_nsg_rule #fo for each we are passing the name expressioin intialzied
  #the map key and map value each.key and each.value
  #each.key 110 120 130
  #each.value 22 80 443
  name                        = "Rule_port_${each.value}" #rule_port_22 #from for each it will get the key 
  priority                    = each.key                  #110 #110 #it will also get the key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"        #any where in the world
  destination_port_range      = each.value #22 #it will get the value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my-rg.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}

