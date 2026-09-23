resource "azurerm_linux_virtual_machine" "web-vm" {
  name = "${local.name_prefix}-${var.resource_group_name}-web-vm"
  #this vnet need location and resource group
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
  size                = "Standard_F2as_v7"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.web_nic.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
    #this is an pre-define meta argument in terraform path.module will always look for the file in current directory 
    #public_key = file("C:\Users\gopal\OneDrive\Desktop\terraform-project\ssh-keys\terraform-azure.pem")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app.sh")
}

#Standard Fasv7 Family vCPUs