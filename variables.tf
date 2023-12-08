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

# Eventhubs
variable "custom_eventhub_components_names" {
  type = object({
    namespace      = optional(string)
    namespace_rule = optional(string)
    topic          = optional(string)
    topic_rule     = optional(string)
  })
  description = "Specifies the custom name of the resources in Eventhub module"
  default     = {}
}

variable "custom_resource_group_name" {
  type        = string
  description = "Custom name for Resource Group"
  default     = null
}

# Key Vault Config
variable "key_vault_id" {
  type        = string
  description = "Azure Key Vault ID to use"
}

variable "key_vault_name" {
  type        = string
  description = "Azure Key Vault Name to use"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID to use"
}

variable "secrets_expiration_date" {
  type        = string
  description = "Expiration UTC datetime (Y-m-d'T'H:M:S'Z')"
  default     = "2024-12-21T00:00:00Z"
}

# Event Hub
variable "eventhub_enabled" {
  type        = bool
  description = "Boolean flag to specify whether Azure Event Hub is provisioned"
  default     = false
}

variable "eventhub_topics" {
  type = map(object({
    partition_count   = string
    message_retention = string
    permissions       = list(string)
  }))
  description = "Map of eventhub topics"
  default     = {}
}

# Debezium
variable "debezium_enabled" {
  type        = bool
  description = "Boolean flag to specify whether Container Instance with Debezium is provisioned"
  default     = false
}

variable "debezium_encryption_key" {
  type        = bool
  description = "Boolean flag to specify whether Container Instance with Debezium is CMK encrypted "
  default     = false
}

variable "debezium_mssql_db_name" {
  type        = string
  description = "Name of target Database which would be used by Debezium"
  default     = ""
}

variable "debezium_mssql_tables" {
  type        = list(string)
  description = "Tables with CDC enabled in target Database"
  default     = []
}

variable "container_config" {
  type = map(object({
    image  = string
    cpu    = string
    memory = string
  }))
  description = "Version and capacity config for container"
  default = {
    "debezium" = {
      image  = "debezium/connect:1.9",
      cpu    = "4",
      memory = "2"
    }
  }
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

variable "sql_azure_ad_admin_object_id" {
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
