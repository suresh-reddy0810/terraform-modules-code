resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg_name
  location                 = var.location
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
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.sub2_private_id

  private_service_connection {
    name                           = "storage-connection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
