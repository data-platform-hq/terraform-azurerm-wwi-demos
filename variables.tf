variable "project" {
  type        = string
  description = "Project name"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "location" {
  type        = string
  description = "Azure location"
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group in which to create MSSQL Server"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
  default     = {}
}

# Key Vault Config
variable "key_vault_id" {
  type        = string
  description = "Azure Key Vault ID to use"
}

variable "secrets_expiration_date" {
  type        = string
  description = "Expiration UTC datetime (Y-m-d'T'H:M:S'Z')"
  default     = "2024-12-21T00:00:00Z"
}

# MSSQL
variable "mssql_server_name" {
  type        = string
  description = "Azure Custom MSSQL Server Name to use"
}

variable "mssql_enabled" {
  type        = bool
  description = "Azure SQL deployment switch"
  default     = false
}

variable "sql_server_admin_login" {
  type        = string
  description = "The administrator login name for Azure SQL server"
  default     = "dpaf"
}

variable "admin_password" {
  type        = string
  description = "Azure Admin Password to use"
  default     = null
}

variable "sql_azure_ad_admin_login" {
  type        = string
  description = "The login username of the Azure AD Administrator of this SQL Server."
  default     = null
}

variable "demos_sql_azure_ad_object_id" {
  type        = string
  description = "The login username of the Azure AD Administrator of this SQL Server."
  default     = null
}

variable "mssql_server_ip_rules" {
  type        = map(string)
  description = "CIDR ranges allowed to access MSSQL Server"
  default     = {}
}

variable "mssql_defender_state" {
  description = "Manages Microsoft Defender state on the mssql server"
  type        = string
  default     = "Disabled"
}

variable "mssql_tde_key_enabled" {
  type        = bool
  description = "MSSQL tde key enable switch"
  default     = false
}

variable "mssql_database" {
  type        = map(any)
  description = "Map of databases to be deployed in Azure SQL"
  default     = {}
}

# Microsoft WWI Demo
variable "microsoft_wwi_demo_enabled" {
  type        = bool
  description = "Boolean flag that determines whether Microsoft WWI Demo in provisioned within Environment"
  default     = false
}

variable "wwi_demo_subnet_id" {
  type        = string
  description = "Microsoft WWI subnet"
  default     = null
}
