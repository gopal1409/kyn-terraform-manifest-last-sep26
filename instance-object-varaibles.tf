variable "instance" {
  description = "map of azure vm instance"
  type = map(object({
    vm_size = string
    availability_zone = string 
    subnet_id = string  
  }))
default = {
  "web1" = {
    vm_size = "Standard_F2as_v7"
    availability_zone = "1" #each.value.availability_zone 1
    subnet_id = "web"
  }
  "web2" = {
    vm_size = "Standard_D2alds_v7"
    availability_zone = "2" #each.value.availability_zone 2
    subnet_id = "web"
  }
  
}
}