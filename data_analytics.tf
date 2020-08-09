## Data Platform components

module "datalake_storage" {
  source = "./datalake"

  for_each        = var.datalake_configs
  prefix          = local.prefix
  convention      = local.global_settings.convention
  location        = each.value.location
  subnet_ids      = local.vnets[each.value.vnet_key].subnet_ids_map[each.value.subnet_key].id
  datalake_config = each.value
}

module "dap_synapse_workspace" {
  source = "./synapse"

  for_each       = var.synapse_configs
  prefix         = local.prefix
  convention     = local.global_settings.convention
  location       = each.value.location
  synapse_config = each.value
  subnet_ids     = local.vnets[each.value.vnet_key].subnet_ids_map[each.value.subnet_key].id
}

module "dap_aml_workspace" {
  source = "./machine_learning"

  for_each                = var.aml_configs
  prefix                  = local.prefix
  convention              = local.global_settings.convention
  location                = each.value.location
  aml_config              = each.value
  subnet_ids              = local.vnets[each.value.vnet_key].subnet_ids_map[each.value.subnet_key].id
  akv_config              = each.value.akv_config
  tags                    = var.tags
  diagnostics_map         = local.caf_foundations_accounting[each.value.location].diagnostics_map
  log_analytics_workspace = local.caf_foundations_accounting[each.value.location].log_analytics_workspace
}


## ---22 - Jul -- New feature
#provider "databricks" {}

/* module "dap_databricks" {
  source = "./databricks"

  #for_each              = var.databricks_config
  #databricks_config     = each.value 
} */


module "dap_data_factory" {
  source = "./data_factory"

  for_each    = var.data_factory_config
  data_factory_config = each.value
}

module "dap_cosmos_db" {
  source = "./cosmos_db"

  for_each    = var.cosmos_db_config
  cosmos_db_config = each.value
}