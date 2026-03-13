output "vnet_name" {
    value = azurerm_virtual_network.vnet.name
}
output "vnet_cicdr" {
    value = azurerm_virtual_network.vnet.address_space
}
output "sub1_name" {
    value = azurerm_subnet.sub1.name
}
output "sub1_cicdr" {
    value = azurerm_subnet.sub1.address_prefixes
}

output "sub2_name" {
    value = azurerm_subnet.sub2_private.name
}

output "sub2_cicdr" {
    value = azurerm_subnet.sub2_private.address_prefixes
}
output "sub1_id" {
value = azurerm_subnet.sub1.id
}
output "sub2_private_id" {
  value = azurerm_subnet.sub2_private.id
}
output "vnet_id" {
    value = azurerm_virtual_network.vnet.id
}