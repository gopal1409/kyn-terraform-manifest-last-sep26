resource "azurerm_resource_group" "my-rg" { #my-rf is the refrence block
  name = "${local.name_prefix}-${var.resource_group_name}"
  #kyn-project-dev-rg-gopal
  #variable "resource_group_name" it will pick up the default value
  location = var.resource_group_location
  tags     = local.project_tags
}


