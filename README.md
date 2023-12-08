# Azure WWI Demo Terraform module
Terraform module for creation Azure WWI Demo and it's components creation

## Usage
This module is provisioning Azure WWI Demo
```hcl
```
<!-- BEGIN_TF_DOCS -->
## Requirements
| Name                                                                      | Version   |
|---------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.65.0 |

## Providers

| Name                                                           | Version   |
|----------------------------------------------------------------|-----------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm)  | >= 3.65.0 |

## Modules
| Module                                                                      | Path   |  Version
|---------------------------------------------------------------------------|-----------|-----------|
[Resource Group Debezium](https://github.com/data-platform-hq/terraform-azurerm-resource-group)|"data-platform-hq/resource-group/azurerm" | 1.3.0  |
[Eventhub](https://github.com/data-platform-hq/terraform-azurerm-eventhub)|"data-platform-hq/eventhub/azurerm" | 1.1.0  |
[Logic APP Workflow API](https://github.com/data-platform-hq/terraform-azurerm-logic-app-workflow)|"data-platform-hq/logic-app-workflow/azurerm" | 1.1.4  |
[Debezium](https://github.com/data-platform-hq/terraform-azurerm-debezium)|"data-platform-hq/debezium/azurerm" | 1.0.5  |
[MSSQL Server](https://github.com/data-platform-hq/terraform-azurerm-mssql-server)|"data-platform-hq/mssql-server/azurerm" | 1.4.0  |
[MSSQL Database](https://github.com/data-platform-hq/terraform-azurerm-mssql-database)|"data-platform-hq/mssql-database/azurerm" | 1.0.1  |
[MSSQL TDE Key](https://github.com/data-platform-hq/terraform-azurerm-key-vault)|"data-platform-hq/key-vault-key/azurerm" | 1.0.0  |
[Resource Group WWI Demo](https://github.com/data-platform-hq/terraform-azurerm-resource-group)|"data-platform-hq/resource-group/azurerm" | 1.3.0  |
[WWI Demo Virtual Machine](https://github.com/data-platform-hq/terraform-azurerm-linux-vm)|"data-platform-hq/linux-vm/azurerm" | 1.0.2  |
[WWI Demo Virtual Machine Extension](https://github.com/data-platform-hq/terraform-azurerm-vm-extension)|"data-platform-hq/vm-extension/azurerm" | 1.0.1  |

## Resources

| Name                                                                                                                                                          | Type     |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [random_password.sql_server_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.sql_server_databricks_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.sql_server_databricks_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.wwi_demo_login_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_private_key.wwi_demo](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [time_sleep.wwi](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name                                                                                                                            | Description                                                                                               | Type                                                                                                                            | Default | Required |
|---------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|---------|:--------:|
| <a name="input_project"></a> [project](#input\_project)| Project name. | `string`| n/a |   yes    |
| <a name="input_env"></a> [env](#input\_env)| Environment name. | `string`| n/a |   yes    |
| <a name="input_location"></a> [location](#input\_location)| Azure location. | `string`| n/a |   yes    |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource_\group)| The name of the resource group in which to create the storage account. | `string`| n/a |   yes    |
| <a name="input_tags"></a> [tags](#input\_tags)| Resource tags. | `map(any)`| {} |   no    |
| <a name="input_custom_eventhub_components_names"></a> [custom\_eventhub\_components\_names](#input\_custom\_eventhub\_components\_names)| Specifies the custom name of the resources in Eventhub module. | <pre>object({ <br> namespace      = optional(string) <br> namespace_rule = optional(string) <br> topic          = optional(string) <br> topic_rule     = optional(string) <br>})</pre> | {} |   no    |
| <a name="input_custom_resource_group_name"></a> [custom\_resource\_group\_name](#input\_custom\_resource\_group\_name)| Custom name for Resource Group. | `string`| null |   no    |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key_\vault\_id)| Azure Key Vault ID to use. | `string`| n/a |   yes    |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name)| Azure Key Vault Name to use. | `string`| n/a |   yes    |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id)| Azure Tenant ID to use. | `string`| n/a |   yes    |
| <a name="input_secrets_expiration_date"></a> [secrets\_expiration\_date](#input\_secrets\_expiration\_date)| Expiration UTC datetime (Y-m-d'T'H:M:S'Z'). | `string`| 2024-12-21T00:00:00Z |   no    |
| <a name="input_eventhub_enabled"></a> [eventhub\_enabled](#input\_eventhub\_enabled)| Boolean flag to specify whether Azure Event Hub is provisioned. | `bool`| false |   no    |
| <a name="input_eventhub_topics"></a> [eventhub\_topics](#input\_eventhub\_topics)| Map of eventhub topics. | <pre>map(object({ <br> partition_count   = string <br> message_retention = string <br> permissions       = list(string) <br>}))</pre> | {} |   no    |
| <a name="input_debezium_enabled"></a> [debezium\_enabled](#input\_debezium\_enabled)| Boolean flag to specify whether Container Instance with Debezium is provisioned. | `bool`| false |   no    |
| <a name="input_debezium_encryption_key"></a> [debezium\_encryption\_key](#input\_debezium\_encryption\_key)| Boolean flag to specify whether Container Instance with Debezium is CMK encrypted. | `bool`| false |   no    |
| <a name="input_debezium_mssql_db_name"></a> [debezium\_mssql\_db\_name](#input\_debezium\_mssql\_db\_name)| Name of target Database which would be used by Debezium. | `string`| "" |   no    |
| <a name="input_debezium_mssql_tables"></a> [debezium\_mssql\_tables](#input\_debezium\_mssql\_tables)| Tables with CDC enabled in target Database. | `list(string)`| [] |   no    |
| <a name="input_container_config"></a> [container\_config](#input\_container\_config)| Version and capacity config for container. | <pre>map(object({ <br> image  = string <br> cpu    = string <br> memory = string <br>}))</pre>| <pre>{ <br/> "debezium" = { <br> &nbsp; image  = "debezium/connect:1.9", <br> &nbsp; cpu    = "4", <br> &nbsp; memory = "2" <br> &nbsp; }<br>}</pre> |   no    |
| <a name="input_mssql_enabled"></a> [mssql\_enabled](#input\_mssql\_enabled)| Azure SQL deployment switch. | `bool`| false |   no    |
| <a name="input_sql_server_admin_login"></a> [sql\_server\_admin\_login](#input\_sql\_server\_admin\_login)| The administrator login name for Azure SQL server. | `string`| dpaf |   no    |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password)| Azure Admin Password to use. | `string`| null |   no    |
| <a name="input_sql_azure_ad_admin_login"></a> [sql\_azure\_ad\_admin\_login](#input\_sql\_azure\_ad\_admin\_login)| The login username of the Azure AD Administrator of this SQL Server. | `string`| null |   no    |
| <a name="input_sql_azure_ad_admin_object_id"></a> [sql\_azure\_ad\_admin\_object\_id](#input\_sql\_azure\_ad\_admin\_object\_id)| The object id of the Azure AD Administrator of this SQL Server. | `string`| null |   no    |
| <a name="input_mssql_server_ip_rules"></a> [mssql\_server\_ip\_rules](#input\_mssql\_server\_ip\_rules)| Azure MSSQL Server IP rules to use. | `map(string)`| {} |   no    |
| <a name="input_mssql_defender_state"></a> [mssql\_defender\_state](#input\_mssql\_defender\_state)| Manages Microsoft Defender state on the mssql server. | `string`| Disabled |   no    |
| <a name="input_mssql_tde_key_enabled"></a> [mssql\_tde\_key\_enabled](#input\_mssql\_tde\_key\_enabled)| MSSQL tde key enable switch. | `bool`| false |   no    |
| <a name="input_mssql_server_name"></a> [mssql\_server\_name](#input\_mssql\_server\_name)| Azure Custom MSSQL Server Name to use. | `string`| n/a |   yes    |
| <a name="input_mssql_database"></a> [mssql\_database](#input\_mssql\_database)| Map of databases to be deployed in Azure SQL. | `map(any)`| {} |   no    |
| <a name="input_microsoft_wwi_demo_enabled"></a> [microsoft\_wwi\_demo\_enabled](#input\_microsoft\_wwi\_demo\_enabled)| Boolean flag that determines whether Microsoft WWI Demo in provisioned within Environment. | `bool`| false |   no    |
| <a name="input_wwi_demo_subnet_id"></a> [wwi\_demo\_subnet\_id](#input\_wwi\_demo\_subnet\_id)| Microsoft WWI subnet. | `string #list(any)`| null |   no    |

## Outputs

| Name                                                               | Description                          |
|--------------------------------------------------------------------|--------------------------------------|
| <a name="eventhub"></a> [eventhub](#output\_eventhub)   | Azure Eventhub. |
| <a name="mssql_server"></a> [mssql\_server](#output\_mssql\_server)   | Azure MSSQL Server. |
| <a name="mssql_database"></a> [mssql\_database](#output\_mssql\_database)   | Azure MSSQL Database. |
| <a name="wwi_demo_virtual_machine"></a> [wwi\_demo\_virtual\_machine](#output\_wwi\_demo\_virtual\_machine)   | Azure WWI Demo Virtual Machine. |
| <a name="random_password"></a> [random\_password](#output\_random\_password)   | Azure Random Password. |

<!-- END_TF_DOCS -->


## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-wwi-demos/tree/master/LICENSE)
