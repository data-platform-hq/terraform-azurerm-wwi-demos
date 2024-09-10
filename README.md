# Azure WWI Demo Terraform module
Terraform module for creation Azure WWI Demo and it's components creation

## Usage
This module is provisioning Azure WWI Demo
```hcl
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.9.2 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.2 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_debezium"></a> [debezium](#module\_debezium) | data-platform-hq/debezium/azurerm | 1.0.5 |
| <a name="module_eventhub"></a> [eventhub](#module\_eventhub) | data-platform-hq/eventhub/azurerm | 1.1.0 |
| <a name="module_logic_app_workflow_api"></a> [logic\_app\_workflow\_api](#module\_logic\_app\_workflow\_api) | data-platform-hq/logic-app-workflow/azurerm | 1.1.4 |
| <a name="module_mssql_database"></a> [mssql\_database](#module\_mssql\_database) | data-platform-hq/mssql-database/azurerm | 1.1.0 |
| <a name="module_mssql_server"></a> [mssql\_server](#module\_mssql\_server) | data-platform-hq/mssql-server/azurerm | 1.4.0 |
| <a name="module_mssql_tde_key"></a> [mssql\_tde\_key](#module\_mssql\_tde\_key) | data-platform-hq/key-vault-key/azurerm | 1.0.0 |
| <a name="module_resource_group_debezium"></a> [resource\_group\_debezium](#module\_resource\_group\_debezium) | data-platform-hq/resource-group/azurerm | 1.3.0 |
| <a name="module_resource_group_wwi_demo"></a> [resource\_group\_wwi\_demo](#module\_resource\_group\_wwi\_demo) | data-platform-hq/resource-group/azurerm | 1.3.0 |
| <a name="module_wwi_demo_secrets"></a> [wwi\_demo\_secrets](#module\_wwi\_demo\_secrets) | data-platform-hq/key-vault-secret/azurerm | 1.0.1 |
| <a name="module_wwi_demo_virtual_machine"></a> [wwi\_demo\_virtual\_machine](#module\_wwi\_demo\_virtual\_machine) | data-platform-hq/linux-vm/azurerm | 1.0.2 |
| <a name="module_wwi_demo_virtual_machine_extension"></a> [wwi\_demo\_virtual\_machine\_extension](#module\_wwi\_demo\_virtual\_machine\_extension) | data-platform-hq/vm-extension/azurerm | 1.0.1 |

## Resources

| Name | Type |
|------|------|
| [random_password.sql_server_admin_password](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |
| [random_password.sql_server_databricks_password](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |
| [random_password.wwi_demo_login_password](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |
| [time_sleep.wwi](https://registry.terraform.io/providers/hashicorp/time/0.9.2/docs/resources/sleep) | resource |
| [tls_private_key.wwi_demo](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Azure Admin Password to use | `string` | `null` | no |
| <a name="input_container_config"></a> [container\_config](#input\_container\_config) | Version and capacity config for container | <pre>map(object({<br>    image  = string<br>    cpu    = string<br>    memory = string<br>  }))</pre> | <pre>{<br>  "debezium": {<br>    "cpu": "4",<br>    "image": "debezium/connect:1.9",<br>    "memory": "2"<br>  }<br>}</pre> | no |
| <a name="input_custom_eventhub_components_names"></a> [custom\_eventhub\_components\_names](#input\_custom\_eventhub\_components\_names) | Specifies the custom name of the resources in Eventhub module | <pre>object({<br>    namespace      = optional(string)<br>    namespace_rule = optional(string)<br>    topic          = optional(string)<br>    topic_rule     = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_custom_resource_group_name"></a> [custom\_resource\_group\_name](#input\_custom\_resource\_group\_name) | Custom name for Resource Group | `string` | `null` | no |
| <a name="input_debezium_enabled"></a> [debezium\_enabled](#input\_debezium\_enabled) | Boolean flag to specify whether Container Instance with Debezium is provisioned | `bool` | `false` | no |
| <a name="input_debezium_encryption_key"></a> [debezium\_encryption\_key](#input\_debezium\_encryption\_key) | Boolean flag to specify whether Container Instance with Debezium is CMK encrypted | `bool` | `false` | no |
| <a name="input_debezium_mssql_db_name"></a> [debezium\_mssql\_db\_name](#input\_debezium\_mssql\_db\_name) | Name of target Database which would be used by Debezium | `string` | `""` | no |
| <a name="input_debezium_mssql_tables"></a> [debezium\_mssql\_tables](#input\_debezium\_mssql\_tables) | Tables with CDC enabled in target Database | `list(string)` | `[]` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment name | `string` | n/a | yes |
| <a name="input_eventhub_enabled"></a> [eventhub\_enabled](#input\_eventhub\_enabled) | Boolean flag to specify whether Azure Event Hub is provisioned | `bool` | `false` | no |
| <a name="input_eventhub_topics"></a> [eventhub\_topics](#input\_eventhub\_topics) | Map of eventhub topics | <pre>map(object({<br>    partition_count   = string<br>    message_retention = string<br>    permissions       = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | Azure Key Vault ID to use | `string` | n/a | yes |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Azure Key Vault Name to use | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | n/a | yes |
| <a name="input_microsoft_wwi_demo_enabled"></a> [microsoft\_wwi\_demo\_enabled](#input\_microsoft\_wwi\_demo\_enabled) | Boolean flag that determines whether Microsoft WWI Demo in provisioned within Environment | `bool` | `false` | no |
| <a name="input_mssql_database"></a> [mssql\_database](#input\_mssql\_database) | Map of databases to be deployed in Azure SQL | `map(any)` | `{}` | no |
| <a name="input_mssql_defender_state"></a> [mssql\_defender\_state](#input\_mssql\_defender\_state) | Manages Microsoft Defender state on the mssql server | `string` | `"Disabled"` | no |
| <a name="input_mssql_enabled"></a> [mssql\_enabled](#input\_mssql\_enabled) | Azure SQL deployment switch | `bool` | `false` | no |
| <a name="input_mssql_server_ip_rules"></a> [mssql\_server\_ip\_rules](#input\_mssql\_server\_ip\_rules) | CIDR ranges allowed to access MSSQL Server | `map(string)` | `{}` | no |
| <a name="input_mssql_server_name"></a> [mssql\_server\_name](#input\_mssql\_server\_name) | Azure Custom MSSQL Server Name to use | `string` | n/a | yes |
| <a name="input_mssql_tde_key_enabled"></a> [mssql\_tde\_key\_enabled](#input\_mssql\_tde\_key\_enabled) | MSSQL tde key enable switch | `bool` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group in which to create MSSQL Server | `string` | n/a | yes |
| <a name="input_secrets_expiration_date"></a> [secrets\_expiration\_date](#input\_secrets\_expiration\_date) | Expiration UTC datetime (Y-m-d'T'H:M:S'Z') | `string` | `"2024-12-21T00:00:00Z"` | no |
| <a name="input_sql_azure_ad_admin_login"></a> [sql\_azure\_ad\_admin\_login](#input\_sql\_azure\_ad\_admin\_login) | The login username of the Azure AD Administrator of this SQL Server. | `string` | `null` | no |
| <a name="input_sql_azure_ad_admin_object_id"></a> [sql\_azure\_ad\_admin\_object\_id](#input\_sql\_azure\_ad\_admin\_object\_id) | The login username of the Azure AD Administrator of this SQL Server. | `string` | `null` | no |
| <a name="input_sql_server_admin_login"></a> [sql\_server\_admin\_login](#input\_sql\_server\_admin\_login) | The administrator login name for Azure SQL server | `string` | `"dpaf"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(any)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Azure Tenant ID to use | `string` | n/a | yes |
| <a name="input_wwi_demo_subnet_id"></a> [wwi\_demo\_subnet\_id](#input\_wwi\_demo\_subnet\_id) | Microsoft WWI subnet | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventhub"></a> [eventhub](#output\_eventhub) | Eventhub related outputs |
| <a name="output_mssql_database"></a> [mssql\_database](#output\_mssql\_database) | MSSQL Database elated outputs |
| <a name="output_mssql_server"></a> [mssql\_server](#output\_mssql\_server) | MSSQL Server related outputs |
| <a name="output_random_password"></a> [random\_password](#output\_random\_password) | Password for Admin Login on WWI SQL Server |
| <a name="output_wwi_demo_virtual_machine"></a> [wwi\_demo\_virtual\_machine](#output\_wwi\_demo\_virtual\_machine) | Microsoft WWI SQL Server related outputs |
<!-- END_TF_DOCS -->


## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-wwi-demos/tree/master/LICENSE)