######################################################
# This file defines which value are sent to output
######################################################

######################################################
# KeyVault Output
######################################################

#####################################################
#KeyvaultId
output "PortalCreatedKeyVaulId" {
  value = "${data.azurerm_key_vault.PortalcreatedKeyvault.id}"
}

output "TerraCreatedKeyVaulId" {
  value = "${data.azurerm_key_vault.TerraCreatedKeyVault.id}"
}

#####################################################
#Keyvault URI
output "PortalCreatedKeyVaultVaultUri" {
  value = "${data.azurerm_key_vault.PortalcreatedKeyvault.vault_uri}"
}

output "TerraCreatedKeyVaultVaultUri" {
  value = "${data.azurerm_key_vault.TerraCreatedKeyVault.vault_uri}"
}

#####################################################
#Keyvault Access Policies

output "PortalCreatedKeyVaultVaultAccessPolicy" {
  value = "${data.azurerm_key_vault.PortalcreatedKeyvault.access_policy}"
}

output "TerraCreatedKeyVaultVaultAccessPolicy" {
  value = "${data.azurerm_key_vault.TerraCreatedKeyVault.access_policy}"
}

#####################################################
#Keyvault Secrets

output "PortalCreatedKeyVaultPwdValue" {
  value     = "${data.azurerm_key_vault_secret.SecretVMPwdPortalCreatedKV.value}"
  sensitive = true
}

output "PortalCreatedKeyVaultPwdId" {
  value = "${data.azurerm_key_vault_secret.SecretVMPwdPortalCreatedKV.id}"
}

output "PortalCreatedKeyVaultPwdContentType" {
  value = "${data.azurerm_key_vault_secret.SecretVMPwdPortalCreatedKV.content_type}"
}

output "TerraCreatedKeyVaultPwdValue" {
  value     = "${data.azurerm_key_vault_secret.SecretVMPwdTerraCreatedKV.value}"
  sensitive = true
}

output "TerraCreatedKeyVaultPwdId" {
  value = "${data.azurerm_key_vault_secret.SecretVMPwdTerraCreatedKV.id}"
}

output "TerraCreatedKeyVaultPwdContentType" {
  value = "${data.azurerm_key_vault_secret.SecretVMPwdTerraCreatedKV.content_type}"
}
