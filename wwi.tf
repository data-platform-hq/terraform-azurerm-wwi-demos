module "resource_group_wwi_demo" {
  count   = var.microsoft_wwi_demo_enabled ? 1 : 0
  source  = "data-platform-hq/resource-group/azurerm"
  version = "1.4.0"

  project  = var.project
  env      = var.env
  location = var.location
  suffix   = "wwi-demo"
  tags     = var.tags
}

# Virtual Machine for WWI Demo
module "wwi_demo_virtual_machine" {
  count   = var.microsoft_wwi_demo_enabled ? 1 : 0
  source  = "data-platform-hq/linux-vm/azurerm"
  version = "1.1.0"

  project        = var.project
  env            = var.env
  resource_group = module.resource_group_wwi_demo[0].name
  location       = var.location
  suffix         = "wwi-demo"
  subnet_id      = var.wwi_demo_subnet_id
  admin_ssh_key  = { public_key = tls_private_key.wwi_demo[0].public_key_openssh }
}

resource "time_sleep" "wwi" {
  count = var.microsoft_wwi_demo_enabled ? 1 : 0

  create_duration = "90s"

  depends_on = [module.wwi_demo_virtual_machine]
}

# This Virtual Machine Extension restores Microsoft WWI Database from backup file
module "wwi_demo_virtual_machine_extension" {
  count   = var.microsoft_wwi_demo_enabled ? 1 : 0
  source  = "data-platform-hq/vm-extension/azurerm"
  version = "1.2.0"

  extensions = {
    name               = "wwi-backup-restoration"
    virtual_machine_id = try(module.wwi_demo_virtual_machine[0].id, null)
    settings = jsonencode({
      "script" : (base64encode(templatefile("${path.module}/scripts/microsoft_wwi_demo_backup_restore.sh", {
        mssql_sa_password = random_password.wwi_demo_login_password[0].result
      })))
    })
  }

  depends_on = [time_sleep.wwi]
}
