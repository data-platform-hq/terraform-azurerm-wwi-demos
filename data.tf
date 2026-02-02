# MSSQL secrets
resource "random_password" "sql_server_admin_password" {
  count = var.mssql_enabled ? 1 : 0

  length           = 16
  special          = true
  override_special = "_%@"
}

resource "random_password" "sql_server_databricks_password" {
  count = var.mssql_enabled ? 1 : 0

  length           = 32
  special          = true
  override_special = "_%@"
}

# SSH Key for WWI Virtual Machine access
resource "tls_private_key" "wwi_demo" {
  count = var.microsoft_wwi_demo_enabled ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 4096
}

# Password for Admin Login on WWI SQL Server
resource "random_password" "wwi_demo_login_password" {
  count = var.microsoft_wwi_demo_enabled ? 1 : 0

  length           = 12
  special          = false
  override_special = "_!@#$%&*()-+="
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
}
