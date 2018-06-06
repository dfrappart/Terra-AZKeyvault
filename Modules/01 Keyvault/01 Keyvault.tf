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

variable "KeyVaultObjectIDPolicy1" {
  type = "string"
}

variable "KeyVaultObjectIDPolicy2" {
  type = "string"
}

variable "KeyVaultTenantID" {
  type = "string"
}

variable "KeyVaultApplicationID" {
  type = "string"
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

#######################
#Variable for Policy 1
variable "KeyVaultCertpermlistPolicy1" {
  type    = "list"
  default = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update"]
}

variable "KeyVaultKeyPermlistPolicy1" {
  type    = "list"
  default = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
}

variable "KeyVaultSecretPermlistPolicy1" {
  type    = "list"
  default = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}

#######################
#Variable for Policy 2
variable "KeyVaultCertpermlistPolicy2" {
  type    = "list"
  default = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update"]
}

variable "KeyVaultKeyPermlistPolicy2" {
  type    = "list"
  default = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
}

variable "KeyVaultSecretPermlistPolicy2" {
  type    = "list"
  default = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
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

  ########################
  #Access Policy 1 for user

  access_policy {
    object_id = "${var.KeyVaultObjectIDPolicy1}"
    tenant_id = "${var.KeyVaultTenantID}"

    #application_id          = "${var.KeyVaultApplicationID}"
    certificate_permissions = ["${var.KeyVaultCertpermlistPolicy1}"]
    key_permissions         = ["${var.KeyVaultKeyPermlistPolicy1}"]
    secret_permissions      = ["${var.KeyVaultSecretPermlistPolicy1}"]
  }

  ########################
  #Access Policy 2 for app

  access_policy {
    object_id = "${var.KeyVaultObjectIDPolicy2}"
    tenant_id = "${var.KeyVaultTenantID}"

    application_id          = "${var.KeyVaultApplicationID}"
    certificate_permissions = ["${var.KeyVaultCertpermlistPolicy2}"]
    key_permissions         = ["${var.KeyVaultKeyPermlistPolicy2}"]
    secret_permissions      = ["${var.KeyVaultSecretPermlistPolicy2}"]
  }

  ########################
  #Others Keyvault param

  enabled_for_deployment          = "${var.KeyVaultEnabledforDeployment}"
  enabled_for_disk_encryption     = "${var.KeyVaultEnabledforDiskEncrypt}"
  enabled_for_template_deployment = "${var.KeyVaultEnabledforTempDeploy}"

  ########################
  #Tags

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
