resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = data.terraform_remote_state.rg.outputs.location
  resource_group_name = data.terraform_remote_state.rg.outputs.rg_name
  dns_prefix          = "ramyaaks"

  default_node_pool {
    name            = "system"
    node_count      = 2
    vm_size         = "Standard_DS2_v2"
    vnet_subnet_id  = data.terraform_remote_state.vnet.outputs.sub1_name
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
  }
}