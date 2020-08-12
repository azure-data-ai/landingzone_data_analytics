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

data_factory_config = {
  data_factory_sg = {
    location              = "southeastasia"
    resource_group_name   = "dap-datafactory"
    workspace_name        = "databricswrkspc101"
  }
}

