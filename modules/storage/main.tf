resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = data.terraform_remote_state.rg.outputs.rg_name
  location                 = data.terraform_remote_state.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  public_network_access_enabled = false

  tags = {
    environment = "dev"
  }
}

# Private Endpoint
resource "azurerm_private_endpoint" "pe" {
  name                = "storage-private-endpoint"
  location            = data.terraform_remote_state.rg.location
  resource_group_name = data.terraform_remote_state.rg.rg_name
  subnet_id           = data.terraform_remote_state.vnet.sub2_private_id

  private_service_connection {
    name                           = "storage-connection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
data "terraform_remote_state" "rg" {
  backend = "local"
  config = {
    path = "../rg/terraform.tfstate"
  }
}