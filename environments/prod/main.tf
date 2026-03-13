module "rg" {
    source = "../../modules/rg/"
    rg_name = var.rg_name
    location = var.location
}

module "vnet" {
    source = "../../modules/vnet/"
    vnet_name = var.vnet_name
    vnet_cicdr = var.vnet_cicdr
    sub1_name = var.sub1_name
    sub1_cicdr = var.sub1_cicdr
    sub2_name = var.sub2_name
    sub2_cicdr = var.sub2_cicdr
    nsg_name = var.nsg_name
}

module "vm" {
    source = "../../modules/vm/"
    vm_name = var.vm_name
    nic_name = var.nic_name

}

module "storage" {
    source = "../../modules/storage/"
    storage_account_name = var.storage_account_name
}

module "webapp" {
    source = "../../modules/webapp/"
    app_service_name = var.app_service_name
    service_plan_name = var.service_plan_name
}

module "aks" {
    source = "../../modules/aks/"
    aks_name = var.aks_name
}