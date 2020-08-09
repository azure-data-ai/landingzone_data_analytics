## Cosmos DB Account

resource "azurerm_resource_group" "dap_cosmosdb_rg" {
  name     = "dap_cosmosdb_rg"
  location = "southeastasia"
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_cosmosdb_account" "dap_cosmos_account" {
  name                = "dap-cosmos-db-${random_integer.ri.result}"
  location            = azurerm_resource_group.dap_cosmosdb_rg.location
  resource_group_name = azurerm_resource_group.dap_cosmosdb_rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    #location          = var.failover_location
    location          = "eastasia"
    failover_priority = 1
  }

  geo_location {
    prefix            = "dap-cosmos-db-${random_integer.ri.result}-customid"
    location          = azurerm_resource_group.dap_cosmosdb_rg.location
    failover_priority = 0
  }
}


## Cosmos DB SQL API

# Create Database
resource "azurerm_cosmosdb_sql_database" "ex_database" {
  name                = "ex-cosmos-sql-db"
  resource_group_name = azurerm_cosmosdb_account.dap_cosmos_account.resource_group_name
  account_name        = azurerm_cosmosdb_account.dap_cosmos_account.name
  throughput          = 400
}
# Create Container
resource "azurerm_cosmosdb_sql_container" "dap_container_ex" {
  name                = "ex-container"
  resource_group_name = azurerm_cosmosdb_account.dap_cosmos_account.resource_group_name
  account_name        = azurerm_cosmosdb_account.dap_cosmos_account.name
  database_name       = azurerm_cosmosdb_sql_database.ex_database.name
  partition_key_path  = "/definition/id"
  throughput          = 400

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}

/* data "azurerm_cosmosdb_account" "cosmos_db_sqlapi_account" {
  name                = azurerm_cosmosdb_account.dap_cosmos_account.name
  resource_group_name = azurerm_cosmosdb_account.dap_cosmos_account.resource_group_name
} */


