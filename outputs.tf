output "mssql_server" {
  value       = try(module.mssql_server[0][*], null)
  description = "MSSQL Server related outputs"
}

output "mssql_database" {
  value       = try(module.mssql_database[0][*], null)
  description = "MSSQL Database elated outputs"
}

output "wwi_demo_virtual_machine" {
  value       = try(module.wwi_demo_virtual_machine[0][*], null)
  description = "Microsoft WWI SQL Server related outputs"
}

output "random_password" {
  value       = try(random_password.wwi_demo_login_password[0].result, null)
  description = "Password for Admin Login on WWI SQL Server"
}
