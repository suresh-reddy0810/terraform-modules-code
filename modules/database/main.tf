resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sql_server_name
  resource_group_name          = data.terraform_remote_state.rg.outputs.rg_name
  location                     = data.terraform_remote_state.rg.outputs.location
  version                      = "12.0"
  administrator_login          = data.terraform_remote_state.keyvault.outputs.sql-admin-username
  administrator_login_password = data.terraform_remote_state.keyvault.outputs.sql-admin-password
}

resource "azurerm_mssql_database" "database" {
  name      = var.sql_database_name
  server_id = azurerm_mssql_server.sqlserver.id
  sku_name  = "Basic"
}

resource "azurerm_mssql_firewall_rule" "allowazure" {
  name      = "AllowAzureServices"
  server_id = azurerm_mssql_server.sqlserver.id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
 data "terraform_remote_state" "rg" {
  backend = "local"
  config = {
    path = "../rg/terraform.tfstate"
  }
 }
 data "terraform_remote_state" "keyvault" {
  backend = "local"
  config = {
    path = "../keyvault/terraform.tfstate"
  }
 }