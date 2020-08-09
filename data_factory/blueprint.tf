resource "azurerm_resource_group" "data_factory_rg" {
  name     = "data_factory_rg"
  location = "southeastasia"
}

## Data Factory workspace
resource "azurerm_data_factory" "dap_data_factory" {
  name                = "dapdfetl01"
  location            = azurerm_resource_group.data_factory_rg.location
  resource_group_name = azurerm_resource_group.data_factory_rg.name
}



## Linked Services
data "azurerm_storage_account" "df_storage_acc" {
  name                = "rsstoragedemo"
  resource_group_name = "rsResourceGroup"
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "linked_storage" {
  name                = "linked_storage"
  resource_group_name = azurerm_resource_group.data_factory_rg.name
  data_factory_name   = azurerm_data_factory.dap_data_factory.name
  connection_string   = data.azurerm_storage_account.df_storage_acc.primary_connection_string
}

## Create datasets
resource "azurerm_data_factory_dataset_azure_blob" "dataset" {
  name                = "ab_dataset"
  resource_group_name = azurerm_resource_group.data_factory_rg.name
  data_factory_name   = azurerm_data_factory.dap_data_factory.name
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.linked_storage.name

  path     = "training"
  filename = "q&a.txt"
}

## Create Managed Integration Runtime
resource "azurerm_data_factory_integration_runtime_managed" "mngd_intn_runtime" {
  name                = "managed-intn-rntm"
  data_factory_name   = azurerm_data_factory.dap_data_factory.name
  resource_group_name = azurerm_resource_group.data_factory_rg.name
  location            = azurerm_resource_group.data_factory_rg.location

  node_size = "Standard_D8_v3"
}

## Self Hosted runtime
resource "azurerm_data_factory_integration_runtime_self_hosted" "self_htd_intn_rntm" {
  name                = "self-htd-intn-rntm"
  resource_group_name = azurerm_resource_group.data_factory_rg.name
  data_factory_name   = azurerm_data_factory.dap_data_factory.name
}

## Data factory pipeline example
resource "azurerm_data_factory_pipeline" "pipeline_example" {
  name                = "pipeline-example"
  resource_group_name = azurerm_resource_group.data_factory_rg.name
  data_factory_name   = azurerm_data_factory.dap_data_factory.name
}