# Key Vault Secrets related to WWI demo
module "wwi_demo_secrets" {
  count   = anytrue([var.mssql_enabled, var.microsoft_wwi_demo_enabled]) ? 1 : 0
  source  = "data-platform-hq/key-vault-secret/azurerm"
  version = "1.2.0"

  key_vault_id = var.key_vault_id
  secrets = merge(
    var.microsoft_wwi_demo_enabled ? {
      wwi-demo-vm-public-key               = { value = tls_private_key.wwi_demo[0].public_key_openssh }
      wwi-demo-vm-private-key              = { value = tls_private_key.wwi_demo[0].private_key_openssh }
      wwi-demo-server-admin-login-password = { value = random_password.wwi_demo_login_password[0].result }
      wwi-demo-server-url                  = { value = "jdbc:sqlserver://${module.wwi_demo_virtual_machine[0].private_ip}:1433;database=WideWorldImporters;trustServerCertificate=true" }
    } : {},
    var.mssql_enabled ? {
      mssql-server-admin-username      = { value = var.sql_server_admin_login }
      mssql-server-admin-password      = { value = random_password.sql_server_admin_password[0].result }
      mssql-server-databricks-username = { value = "databricks" }
      mssql-server-databricks-password = { value = random_password.sql_server_databricks_password[0].result }
    } : {}
  )
  default_expiration_date = var.secrets_expiration_date
}
