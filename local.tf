#any local block start with locals
locals {
  #name_prefix it is concation of two variables. 
  name_prefix = "${var.project_name}-${var.environment}"
  #kyn-project-dev
  project_tags = { #this project tag is your name 
    Project     = var.project_name
    Environment = var.environment
    Managedby   = "Terraform"

  }
}