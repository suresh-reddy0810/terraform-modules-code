resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "ramyaaks"

  default_node_pool {
    name            = "system"
    node_count      = 2
    vm_size         = "Standard_DS2_v2"
    vnet_subnet_id  = var.sub1_name
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
  }
}