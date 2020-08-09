
/* resource "azurerm_resource_group" "databricks_rg" {
  name     = var.databricks_config.resource_group_name
  location = var.databricks_config.location
}

resource "azurerm_databricks_workspace" "databricks_wrkspc" {
  name                = var.databricks_config.workspace_name
  resource_group_name = azurerm_resource_group.databricks_rg.name
  managed_resource_group_name = "managed_${var.databricks_config.resource_group_name}"
  location            = azurerm_resource_group.databricks_rg.location
  sku                 = "standard"

  #address_spaces = vnet

  tags = {
    Environment = "Production"
  }
} */

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_secret" "pat" {
  name = "pat_secret"
  value = "launchpad"
  key_vault_id = local.keyvaults.id
}

resource "azurerm_resource_group" "databricks_rg" {
  name     = "dap_databrics_rg"
  location = "southeastasia"
}

resource "azurerm_databricks_workspace" "databricks_wrkspc" {
  name                  = "databricswrkspc450"
  resource_group_name   = azurerm_resource_group.databricks_rg.name
  managed_resource_group_name = "managed_${azurerm_resource_group.databricks_rg.name}"
  location              = "southeastasia"
  sku                 = "standard"

  tags = {
    Environment = "Production"
  }
}

provider "databricks" {
  azure_auth = {
    managed_resource_group = "${azurerm_databricks_workspace.databricks_wrkspc.managed_resource_group_name}"
    azure_region           = "${azurerm_databricks_workspace.databricks_wrkspc.location}"
    workspace_name         = "${azurerm_databricks_workspace.databricks_wrkspc.name}"
    resource_group         = "${azurerm_databricks_workspace.databricks_wrkspc.resource_group_name}"
    client_id              = data.azurerm_client_config.current.client_id
    client_secret          = data.azurerm_key_vault_secret.id
    tenant_id              = data.azurerm_client_config.current.tenant_id
    subscription_id        = data.azurerm_client_config.current.subscription_id
  }
} 


resource "databricks_instance_pool" "my-demo-pool" {
  instance_pool_name                    = "demo-terraform-pool"
  min_idle_instances                    = 0
  max_capacity                          = 2
  node_type_id                          = "Standard_DS3_v2"
  idle_instance_autotermination_minutes = 10
  enable_elastic_disk                   = true
  #preloaded_spark_versions              = [var.databricks_cluster_version]
  custom_tags = {
    "creator" : "demo user"
    "testChange" : "demo user"
  }
}