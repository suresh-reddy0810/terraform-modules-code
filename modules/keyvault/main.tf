data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                        = var.keyvault_name
  location                    = data.terraform_remote_state.rg.outputs.location
  resource_group_name         = data.terraform_remote_state.rg.outputs.rg_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "Set",
      "List"
    ]
  }
}

resource "azurerm_key_vault_secret" "sql_database" {
  name         = "sql-admin-username"
  value        = var.sql-admin-username
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "sql_password" {
  name         = "sql-admin-password"
  value        = var.sql-admin-password
  key_vault_id = azurerm_key_vault.keyvault.id
}

data "terraform_remote_state" "rg" {
  backend = "local"
  config = {
    path = "../rg/terraform.tfstate"
  }
}