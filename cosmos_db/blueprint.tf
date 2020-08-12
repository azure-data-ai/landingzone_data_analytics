# Naming Convention
resource "azurecaf_naming_convention" "nc_cosmosdb_rg" {
  name          = var.cosmosdb_config.resource_group_name
  prefix        = var.prefix
  resource_type = "rg"
  max_length    = 50
  convention    = var.convention
}

resource "azurecaf_naming_convention" "nc_cosmos_account" {
  name          = var.cosmosdb_config.cosmosdb_account
  prefix        = var.prefix
  resource_type = "st"
  max_length    = 40
  convention    = var.convention
}

# Create Resources

## Cosmos DB Account
resource "azurerm_resource_group" "dap_cosmosdb_rg" {
  name     = azurecaf_naming_convention.nc_cosmosdb_rg.result
  location = var.cosmosdb_config.location
}

resource "azurerm_cosmosdb_account" "dap_cosmos_account" {
  name                = azurecaf_naming_convention.nc_cosmos_account.result
  location            = var.cosmosdb_config.location
  resource_group_name = azurerm_resource_group.dap_cosmosdb_rg.name
  offer_type          = var.cosmosdb_config.offer_type
  kind                = var.cosmosdb_config.kind

  enable_automatic_failover = var.cosmosdb_config.enable_automatic_failover

  consistency_policy {
    consistency_level       = var.cosmosdb_config.consistency_policy.consistency_level
    max_interval_in_seconds = var.cosmosdb_config.consistency_policy.max_interval_in_seconds
    max_staleness_prefix    = var.cosmosdb_config.consistency_policy.max_staleness_prefix
  }
  
  # Primary location (Write Region)
  geo_location {
    prefix            = "${azurecaf_naming_convention.nc_cosmos_account.result}-${var.cosmosdb_config.primary_geo_location.prefix}"  # used to generate document endpoint
    location          = azurerm_resource_group.dap_cosmosdb_rg.location
    failover_priority = var.cosmosdb_config.primary_geo_location.failover_priority
  }
 
  # failover location
  geo_location {
    location          = var.cosmosdb_config.failover_geo_location.location
    failover_priority = var.cosmosdb_config.failover_geo_location.failover_priority
  }
}


## Cosmos DB SQL API

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create Database
resource "azurerm_cosmosdb_sql_database" "ex_database" {
  name                = "${var.cosmosdb_config.sql_api_databases.database_101.name}-${random_integer.ri.result}"
  resource_group_name = azurerm_cosmosdb_account.dap_cosmos_account.resource_group_name
  account_name        = azurerm_cosmosdb_account.dap_cosmos_account.name
  throughput          = var.cosmosdb_config.sql_api_databases.database_101.throughput
}
# Create Container
resource "azurerm_cosmosdb_sql_container" "dap_container_ex" {
  name                = var.cosmosdb_config.sql_api_databases.database_101.container_101.name
  resource_group_name = azurerm_cosmosdb_account.dap_cosmos_account.resource_group_name
  account_name        = azurerm_cosmosdb_account.dap_cosmos_account.name
  database_name       = azurerm_cosmosdb_sql_database.ex_database.name
  partition_key_path  = var.cosmosdb_config.sql_api_databases.database_101.container_101.partition_key_path
  throughput          = var.cosmosdb_config.sql_api_databases.database_101.container_101.throughput

  unique_key {
    paths = var.cosmosdb_config.sql_api_databases.database_101.container_101.unique_key_path
  }
}

/* data "azurerm_cosmosdb_account" "cosmos_db_sqlapi_account" {
  name                = azurerm_cosmosdb_account.dap_cosmos_account.name
  resource_group_name = azurerm_cosmosdb_account.dap_cosmos_account.resource_group_name
} */


