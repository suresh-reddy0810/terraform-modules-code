resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = data.terraform_remote_state.rg.outputs.rg_name
  resource_group_name = data.terraform_remote_state.rg.outputs.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = data.terraform_remote_state.rg.outputs.location
  resource_group_name = data.terraform_remote_state.rg.outputs.rg_name
  address_space       = var.vnet_cicdr
}

 resource "azurerm_subnet" "sub1" {
  name                 = var.sub1_name
  resource_group_name  = data.terraform_remote_state.rg.outputs.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.sub1_cicdr
 }
 resource "azurerm_subnet" "sub2_private" {
  name                 = var.sub2_name
  resource_group_name  = data.terraform_remote_state.rg.outputs.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.sub2_cicdr
 }
  data "terraform_remote_state" "rg" {
    backend = "local"
    config = {
        path = "../rg/terraform.tfstate"
    }
  }
