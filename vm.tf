resource "azurerm_linux_virtual_machine" "web-vm" {
  for_each = var.instance
  name = "${local.name_prefix}-${var.resource_group_name}-${each.key}-web-vm"
  #this vnet need location and resource group
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
  size                = each.value.vm_size 
  zone = each.value.availability_zone
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.web_nic[each.key].id,
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

output "vm_details" {
  description = "all the vm details"
  value = {
    for name, vm in azurerm_linux_virtual_machine.web-vm : name => {
      vm_id = vm.id 
      vm_name = vm.name 
      zone = vm.zone
      private_ip =  azurerm_network_interface.web_nic[name].private_ip_address
     # public_ip =  azurerm_public_ip.web_vm_publicip[name].ip_address
    }
    

  }
}