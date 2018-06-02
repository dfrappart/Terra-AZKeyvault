######################################################
# This file defines which value are sent to output
######################################################

######################################################
# KeyVault Output
######################################################

output "PortalCreatedKeyVaulId" {
  value = "${data.azurerm_key_vault.PortalcreatedKeyvault.id}"
}

output "PortalCreatedKeyVaultVaultUri" {
  value = "${data.azurerm_key_vault.PortalcreatedKeyvault.vault_uri}"
}

output "PortalCreatedKeyVaultVaultAccessPolicy" {
  value = "${data.azurerm_key_vault.PortalcreatedKeyvault.access_policy}"
}

output "PortalCreatedKeyVaultPwdValue" {
  value = "${data.azurerm_key_vault_secret.SecretVMPwd.value}"
}

output "PortalCreatedKeyVaultPwdId" {
  value = "${data.azurerm_key_vault_secret.SecretVMPwd.id}"
}

output "PortalCreatedKeyVaultPwdContentType" {
  value = "${data.azurerm_key_vault_secret.SecretVMPwd.content_type}"
}
