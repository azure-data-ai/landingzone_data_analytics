# Naming Convention
resource "azurecaf_naming_convention" "nc_stream_analytics_rg" {
  name          = var.stream_analytics_config.resource_group_name
  prefix        = var.prefix
  resource_type = "rg"
  max_length    = 50
  convention    = var.convention
}

resource "azurecaf_naming_convention" "nc_stream_analytics_job_name" {
  name          = var.stream_analytics_config.stream_analytics_job_name
  prefix        = var.prefix
  resource_type = "st"
  max_length    = 40
  convention    = var.convention
}

# Create Resources
resource "azurerm_resource_group" "dap_stream_analytics_rg" {
  name     = azurecaf_naming_convention.nc_stream_analytics_rg.result
  location = var.stream_analytics_config.location
}


## Add Random in Job name
resource "azurerm_stream_analytics_job" "sa_example_job" {
  name                                     = var.stream_analytics_config.stream_analytics_job_name
  resource_group_name                      = azurerm_resource_group.dap_stream_analytics_rg.name
  location                                 = var.stream_analytics_config.location
  compatibility_level                      = var.stream_analytics_config.compatibility_level
  data_locale                              = var.stream_analytics_config.data_locale
  events_late_arrival_max_delay_in_seconds = var.stream_analytics_config.events_late_arrival_max_delay_in_seconds
  events_out_of_order_max_delay_in_seconds = var.stream_analytics_config.events_out_of_order_max_delay_in_seconds
  events_out_of_order_policy               = var.stream_analytics_config.events_out_of_order_policy
  output_error_policy                      = var.stream_analytics_config.output_error_policy
  streaming_units                          = var.stream_analytics_config.streaming_units

  tags = {
    environment = var.stream_analytics_config.tags.environment
  }

  transformation_query = <<QUERY
    SELECT *
    INTO [YourOutputAlias]
    FROM [YourInputAlias]
QUERY

}