terraform {
  backend "azurerm" {
  }
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
    databricks = {
      source = "databrickslabs/databricks"
    }
  }
  required_version = ">= 0.13"
}


/* 
## Install 
curl https://raw.githubusercontent.com/databrickslabs/databricks-terraform/master/godownloader-databricks-provider.sh | bash -s -- -b $HOME/.terraform.d/plugins 
*/


/* locals {
  keyvaults = data.terraform_remote_state.launchpad.outputs.keyvaults
} */