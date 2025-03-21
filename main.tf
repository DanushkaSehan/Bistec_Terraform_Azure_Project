provider "azurerm" {
  features {}  # Required for Azure provider

  resource_provider_registrations = "none"  # No automatic resource provider registrations
  subscription_id = "a2b28c85-1948-4263-90ca-bade2bac4df4"  # KodeKloud Azure sandbox default subscription
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "myAKSClusterBistec"  # Name of the AKS cluster
  location           = "West US"  # Azure region
  resource_group_name = "kml_rg_main-d6c1db9800654916"  # Resource group name(in Kodecloud only have one resource group)
  dns_prefix         = "myaksdns"  # DNS prefix for the cluster

  default_node_pool {
    name       = "agentpool"  # Pool name
    node_count = 2  # Number of nodes in the pool
    vm_size    = "Standard_D2s_v3"  # VM size for the nodes
  }

  identity {
    type = "SystemAssigned"  # Used system assigned managed identity
  }

  tags = {
    environment = "dev"  # Taging for environment classification
  }
}
