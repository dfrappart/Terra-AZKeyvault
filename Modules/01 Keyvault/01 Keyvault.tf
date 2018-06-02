######################################################################
# This module create a keyvault resource
######################################################################

#Variable declaration for Module

variable "KeyVaultName" {
  type = "string"
}

variable "KeyVaultLocation" {
  type    = "string"
  default = "westeurope"
}

variable "KeyVaultRG" {
  type = "string"
}

variable "KeyVaultSKUName" {
  type    = "string"
  default = "standard"
}

variable "KeyVaultObjectID" {
  type = "string"
}

variable "KeyVaultTenantID" {
  type = "string"
}

variable "KeyVaultApplicationID" {
  type = "string"
}

variable "KeyVaultCertpermlist" {
  type    = "list"
  default = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update"]
}

variable "KeyVaultKeyPermlist" {
  type    = "list"
  default = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
}

variable "KeyVaultSecretPermlist" {
  type    = "list"
  default = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}

variable "KeyVaultEnabledforDeployment" {
  type    = "string"
  default = "true"
}

variable "KeyVaultEnabledforDiskEncrypt" {
  type    = "string"
  default = "true"
}

variable "KeyVaultEnabledforTempDeploy" {
  type    = "string"
  default = "true"
}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

#Resource Creation

resource "azurerm_key_vault" "TerraKeyVault" {
  name                = "${lower(var.KeyVaultName)}"
  location            = "${var.KeyVaultLocation}"
  resource_group_name = "${var.KeyVaultRG}"

  sku {
    name = "${var.KeyVaultSKUName}"
  }

  tenant_id = "${var.KeyVaultTenantID}"

  access_policy {
    object_id               = "${var.KeyVaultObjectID}"
    tenant_id               = "${var.KeyVaultTenantID}"
    application_id          = "${var.KeyVaultApplicationID}"
    certificate_permissions = ["${var.KeyVaultCertpermlist}"]
    key_permissions         = ["${var.KeyVaultKeyPermlist}"]
    secret_permissions      = ["${var.KeyVaultSecretPermlist}"]
  }

  enabled_for_deployment          = "${var.KeyVaultEnabledforDeployment}"
  enabled_for_disk_encryption     = "${var.KeyVaultEnabledforDiskEncrypt}"
  enabled_for_template_deployment = "${var.KeyVaultEnabledforTempDeploy}"

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

#VModule Output

output "Id" {
  value = "${azurerm_key_vault.TerraKeyVault.id}"
}

output "URI" {
  value = "${azurerm_key_vault.TerraKeyVault.vault_uri}"
}
