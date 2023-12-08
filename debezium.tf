module "resource_group_debezium" {
  count   = anytrue([var.eventhub_enabled, var.debezium_enabled]) ? 1 : 0
  source  = "data-platform-hq/resource-group/azurerm"
  version = "1.3.0"

  project                    = var.project
  env                        = var.env
  location                   = var.location
  suffix                     = "debezium"
  custom_resource_group_name = var.custom_resource_group_name
  tags                       = var.tags
}

module "eventhub" {
  count   = var.eventhub_enabled ? 1 : 0
  source  = "data-platform-hq/eventhub/azurerm"
  version = "1.1.0"

  project                         = var.project
  env                             = var.env
  location                        = var.location
  custom_namespace_name           = var.custom_eventhub_components_names.namespace
  custom_topic_name               = var.custom_eventhub_components_names.topic
  custom_namespace_auth_rule_name = var.custom_eventhub_components_names.namespace_rule
  custom_topic_auth_rule_name     = var.custom_eventhub_components_names.topic_rule
  tags                            = var.tags
  resource_group                  = module.resource_group_debezium[0].name
  eventhub_topic                  = var.eventhub_topics
}

module "logic_app_workflow_api" {
  count   = var.debezium_enabled ? 1 : 0
  source  = "data-platform-hq/logic-app-workflow/azurerm"
  version = "1.1.4"

  project        = var.project
  env            = var.env
  location       = var.location
  name           = "debezium"
  resource_group = module.resource_group_debezium[0].name
  tags           = var.tags
}

module "debezium" {
  count   = var.debezium_enabled ? 1 : 0
  source  = "data-platform-hq/debezium/azurerm"
  version = "1.0.5"

  project        = var.project
  env            = var.env
  location       = var.location
  resource_group = module.resource_group_debezium[0].name
  tags           = var.tags

  container_config      = var.container_config
  logic_app_workflow_id = module.logic_app_workflow_api[0].id
  connection_string     = module.eventhub[0].namespace_connection_string
  eventhub_name         = module.eventhub[0].namespace_name

  key_vault_id = var.debezium_encryption_key ? { (var.key_vault_name) = var.key_vault_id } : {}
  tenant_id    = var.tenant_id

  mssql_server_name   = module.mssql_server[0].name
  mssql_username      = var.sql_server_admin_login
  mssql_password      = coalesce(var.admin_password, random_password.sql_server_admin_password[0].result)
  mssql_database_name = var.debezium_mssql_db_name
  sql_tables          = var.debezium_mssql_tables

  depends_on = [module.eventhub, module.mssql_server]
}

