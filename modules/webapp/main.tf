resource "azurerm_app_service_plan" "service_plan" {
  name                = var.service_plan_name
  location            = data.terraform_remote_name.rg.location
  resource_group_name = data.terraform_remote_name.rg.rg_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = var.app_service_name
  location            = data.terraform_remote_state.rg.location
  resource_group_name = data.terraform_remote_state.rg.rg_name
  app_service_plan_id = azurerm_app_service_plan.service_plan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

 
}
data "terraform_remote_state" "rg" {
    backend = "local"
    config = {
        path = "../rg/terraform.tfstate"
    }
}