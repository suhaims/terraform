terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm",
      version = "=3.48.0"
    }
  }

  backend "azurerm" {
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
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.nordcloud_demo.location
  resource_group_name = azurerm_resource_group.nordcloud_demo.name
  sku_name            = "F1"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "nordcloud_webapp" {
  name                = var.web_app_name
  location            = azurerm_resource_group.nordcloud_demo.location
  resource_group_name = azurerm_resource_group.nordcloud_demo.name
  service_plan_id     = azurerm_service_plan.nordcloud_asp.id

  site_config {
    always_on = false
  }
}
