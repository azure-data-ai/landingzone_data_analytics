## Parameter value assignment

synapse_configs = {
  synapse_sg = {
    location                 = "southeastasia"
    vnet_key                 = "hub_sg"
    subnet_key               = "Subnet_storage"
    resource_group_name      = "dap-synapse"
    workspace_name           = "synapsewrkspce"
    workspace_tags           = "{\"Type\": \"Data Warehouse\", \"environment\": \"DEV\", \"project\": \"myproject\"}"
    sqlserver_admin_login    = "sqladminuser"
    sqlserver_admin_password = "azureuser@123"

    storage_account = {
      name                      = "synapsestorage"
      account_tier              = "Standard"
      account_kind              = "StorageV2"
      account_replication_type  = "LRS"
      access_tier               = "Hot"
      enable_https_traffic_only = true
      is_hns_enabled            = true ## Must enabled for synpase

      network_rules = {
        default_action = "Deny"
        bypass         = ["AzureServices"]
        #virtual_network_subnet_ids = ["Datalake"]
      }
      #network_rules is optional
    }
  }
}

databricks_config = {
  databricks_sg = {
    location              = "southeastasia"
    resource_group_name   = "dap-databricks"
    workspace_name        = "databricswrkspc450"

  }
}

data_factory_config = {
  data_factory_sg = {
    location              = "southeastasia"
    resource_group_name   = "dap-datafactory"
    workspace_name        = "databricswrkspc101"
  }
}

cosmosdb_config = {
  cosmosdb_sg = {
    location              = "southeastasia"
    resource_group_name   = "dap-cosmosdb"
    cosmosdb_account        = "dap-cosmosdb-ex101"
    offer_type          = "Standard"
    kind                = "GlobalDocumentDB"
    enable_automatic_failover = true

    consistency_policy = {
      consistency_level       = "BoundedStaleness"
      max_interval_in_seconds = 300
      max_staleness_prefix    = 100000
    }

    primary_geo_location = {
      prefix            = "customid-101"
      location          = "southeastasia"
      failover_priority = 0
    }

    failover_geo_location = {
      location          = "eastasia"
      failover_priority = 1
    }

    sql_api_databases = {
      database_101 = {
        name = "cosmos-sql-exdb"
        throughput = 400
        container_101 = {
          name = "container-ex101"
          partition_key_path = "/definition/id"
          throughput = 400
          unique_key_path = ["/definition/idlong", "/definition/idshort"]
        }
      }
    }
  }
}

