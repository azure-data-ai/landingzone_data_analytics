terraform {
  backend "azurerm" {
  }
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 2.26.0"
    }
  }
  required_version = ">= 0.13"
}
