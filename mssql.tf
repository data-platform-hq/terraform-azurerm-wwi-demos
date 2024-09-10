module "mssql_server" {
  count   = var.mssql_enabled ? 1 : 0
  source  = "data-platform-hq/mssql-server/azurerm"
  version = "1.4.0"

  project                  = var.project
  env                      = var.env
  location                 = var.location
  custom_mssql_server_name = var.mssql_server_name
  tags                     = var.tags
  resource_group           = var.resource_group

  admin_login              = var.sql_server_admin_login
  admin_password           = coalesce(var.admin_password, random_password.sql_server_admin_password[0].result)
  azure_ad_admin_login     = var.sql_azure_ad_admin_login
  azure_ad_admin_object_id = var.sql_azure_ad_admin_object_id
  ip_rules                 = var.mssql_server_ip_rules
  tde_encryption_enabled   = var.mssql_tde_key_enabled
  key_vault_id             = var.key_vault_id
  key_vault_key_id         = try(module.mssql_tde_key[0].key_id, "")
  mssql_defender_state     = var.mssql_defender_state
}

module "mssql_database" {
  count   = var.mssql_enabled ? 1 : 0
  source  = "data-platform-hq/mssql-database/azurerm"
  version = "1.1.0"

  server_id   = module.mssql_server[0].id
  server_fqdn = module.mssql_server[0].fqdn
  databases   = var.mssql_database
}

# Azure MSSQL Transparent Data Encryption
module "mssql_tde_key" {
  count   = alltrue([var.mssql_tde_key_enabled, var.mssql_enabled]) ? 1 : 0
  source  = "data-platform-hq/key-vault-key/azurerm"
  version = "1.0.0"

  project                 = var.project
  env                     = var.env
  location                = var.project
  custom_key_name         = "mssql-tde"
  key_vault_id            = var.key_vault_id
  custom_rotation_policy  = {}
  default_expiration_date = var.secrets_expiration_date
}
