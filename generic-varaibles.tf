variable "project_name" {
  description = "project name"
  type        = string
  default     = "kyn-project"
}

variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "dev" #test prod
}

variable "resource_group_name" {
  description = "name of the resource group"
  type        = string
  default     = "rg-gopal"
}

variable "resource_group_location" {
  description = "name of the location"
  type        = string
  default     = "eastus"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "web_subnet_address" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}