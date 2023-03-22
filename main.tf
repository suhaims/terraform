terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm",
      version = "=3.48.0"
    }
  }

  required_version = "=1.4.2"
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "nordcloud_demo" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "nordcloud_asp" {
  name                = "nordclouddemo-appplan"
  location            = azurerm_resource_group.nordcloud_demo.location
  resource_group_name = azurerm_resource_group.nordcloud_demo.name
  sku_name            = "F1"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "nordcloud_webapp" {
  name                = "nordcloud-webapp"
  location            = azurerm_resource_group.nordcloud_demo.location
  resource_group_name = azurerm_resource_group.nordcloud_demo.name
  service_plan_id     = azurerm_service_plan.nordcloud_asp.id

  site_config {

  }
}
