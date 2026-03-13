output "sql-admin-username" {
    value = azurerm_key_vault_secret.sql_database.value
}
output "sql-admin-password" {
    value = azurerm_key_vault_secret.sql_password.value
}

output "keyvault_name" {
    value = azurerm_key_valut.keyvault.name
}