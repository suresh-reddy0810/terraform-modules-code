resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = data.terraform_remote_state.rg.outputs.location
  resource_group_name = data.terraform_remote_state.rg.outputs.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.terraform_remote_state.vnet.outputs.sub1_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = data.terraform_remote_state.rg.outputs.rg_name
  location            = data.terraform_remote_state.rg.outputs.location
  size                = "Standard_F2"
  admin_username      = "suresh"
  admin_password = "Suresh@200208"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
data "terraform_remote_state" "rg" {
    backend = "local"
    config = {
        path = "../rg/terraform.tfstate"
    }
}
data "terraform_remote_state" "vnet" {
    backend = "local"
    config = {
        path = "../vnet/terraform.tfstate"
    }
}
