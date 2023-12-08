module "microsoft_wwi_demo_cases" {
  count  = anytrue([var.mssql_enabled, var.microsoft_wwi_demo_enabled, var.debezium_enabled, var.eventhub_enabled]) ? 1 : 0
  source = "./modules/demos"

  project        = local.project
  env            = var.env
  location       = local.location
  resource_group = module.resource_group.name

  # Key Vault config
  key_vault_name          = module.key_vault.name
  key_vault_id            = module.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  secrets_expiration_date = coalesce(try(data.terraform_remote_state.init.outputs.key_vault.secrets_expiration_date, null), var.secrets_expiration_date)

  # Azure SQL config
  mssql_enabled     = var.mssql_enabled
  mssql_server_name = coalesce(var.custom_mssql_components_names.server, "mssql-${local.project}-${var.env}-${local.location}")
  mssql_server_ip_rules = merge(
    coalesce(var.allowed_ip_address, try(data.terraform_remote_state.init.outputs.ip_rules.allowed_ip_addresses, null)),
  )
  sql_azure_ad_admin_login     = var.sql_azure_ad_admin_login
  sql_azure_ad_admin_object_id = var.user_object_ids[lower(var.sql_azure_ad_admin_login)]
  mssql_tde_key_enabled        = var.mssql_tde_key_enabled
  mssql_database               = var.mssql_database

  # Debezium
  debezium_enabled                 = var.debezium_enabled
  eventhub_enabled                 = var.eventhub_enabled
  custom_eventhub_components_names = var.custom_eventhub_components_names

  # Microsoft WWI Virtual Machine
  microsoft_wwi_demo_enabled = var.microsoft_wwi_demo_enabled
  wwi_demo_subnet_id         = try(module.wwi_demo_subnet[0].id, null)

  depends_on = [module.key_vault]
}
