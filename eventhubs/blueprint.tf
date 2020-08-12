# Naming Convention
resource "azurecaf_naming_convention" "nc_eventhub_rg" {
  name          = var.eventhubs_config.resource_group_name
  prefix        = var.prefix
  resource_type = "rg"
  max_length    = 50
  convention    = var.convention
}

resource "azurecaf_naming_convention" "nc_namespace" {
  name          = var.eventhubs_config.eventhubs_namespace
  prefix        = var.prefix
  resource_type = "st"
  max_length    = 40
  convention    = var.convention
}

# Create Resources
resource "azurerm_resource_group" "dap_eventhub_rg" {
  name     = azurecaf_naming_convention.nc_eventhub_rg.result
  location = var.eventhubs_config.location
}

resource "azurerm_eventhub_namespace" "dap_eventhub_namespace" {
  name                = azurecaf_naming_convention.nc_namespace.result
  location            = var.eventhubs_config.location
  resource_group_name = azurerm_resource_group.dap_eventhub_rg.name
  sku                 = var.eventhubs_config.sku
  capacity            = var.eventhubs_config.capacity

  tags = {
    environment = var.eventhubs_config.tags.environment
  }
}

resource "azurerm_eventhub" "dap_eventhub" {
  name                = var.eventhubs_config.eventhub_101.name
  namespace_name      = azurerm_eventhub_namespace.dap_eventhub_namespace.name
  resource_group_name = azurerm_resource_group.dap_eventhub_rg.name
  partition_count     = var.eventhubs_config.eventhub_101.partition_count
  message_retention   = var.eventhubs_config.eventhub_101.message_retention
}