## Parameter value assignment

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

eventhubs_config = {
  eventhub_sg = {
    location              = "southeastasia"
    resource_group_name   = "dap-eventhubs"
    eventhubs_namespace   = "streamEventHubNamespace101"
    sku                   = "Standard"
    capacity              = 1
    tags = {
      environment = "Production"
    }
    eventhub_101 = {
       name                = "streamDataEventHub101"
       partition_count     = 2
       message_retention   = 1
    }
  }
}

stream_analytics_config = {
  stream_job_sg = {
    location                                 = "southeastasia"
    resource_group_name                      = "dap-stream-analytics"
    stream_analytics_job_name                = "sa-example101-job"

    compatibility_level                      = "1.1"
    data_locale                              = "en-GB"
    events_late_arrival_max_delay_in_seconds = 60
    events_out_of_order_max_delay_in_seconds = 50
    events_out_of_order_policy               = "Adjust"
    output_error_policy                      = "Drop"
    streaming_units                          = 3

    tags = {
      environment = "Prod"
    }
  }
} 
