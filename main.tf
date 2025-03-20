provider "azurerm" {
  features {}
resource_provider_registrations = "none"
  subscription_id = "a2b28c85-1948-4263-90ca-bade2bac4df4"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "myAKSCluster"
  location           = "East US"  
  resource_group_name = "kml_rg_main-b01ac03244b34bf0"
  dns_prefix         = "myaksdns"

  default_node_pool {
    name       = "agentpool"
    node_count = 2
    vm_size    = "Standard_D2s_v3"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "dev"
  }
}
