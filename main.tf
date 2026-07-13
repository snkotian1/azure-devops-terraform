resource "azurerm_resource_group" "aks" {
  name     = "aks-production-rg"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "production-aks-cluster"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "prod-aks-cluster"

  default_node_pool {
    name       = "systempool"
    node_count = 2
    vm_size    = "Standard_D2s_v3"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

providers.tf

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  backend "azurerm" {} # Left empty; populated dynamically by Azure DevOps
}

provider "azurerm" {
  features {}
}
