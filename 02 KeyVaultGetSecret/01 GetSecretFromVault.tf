######################################################
# This file get a secret in a previously deployed
# keyvault
######################################################

######################################################################
# Access to Azure
######################################################################

# Configure the Microsoft Azure Provider with Azure provider variable defined in AzureDFProvider.tf

provider "azurerm" {
  subscription_id = "${var.AzureSubscriptionID1}"
  client_id       = "${var.AzureClientID}"
  client_secret   = "${var.AzureClientSecret}"
  tenant_id       = "${var.AzureTenantID}"
}

######################################################################
# Data sources
######################################################################

data "azurerm_resource_group" "TerraRG" {
  name = "${var.RGName}-${var.EnvironmentUsageTag}${var.EnvironmentTag}"
}

data "azurerm_key_vault" "TerraKeyVault" {
  name                = "keyvaultdftest"
  resource_group_name = "${data.azurerm_resource_group.TerraRG.name}"
}

data "azurerm_resource_group" "PortalcreatedRG" {
  name = "rg-001"
}

data "azurerm_key_vault" "PortalcreatedKeyvault" {
  name                = "dfkeyvaulttest02"
  resource_group_name = "${data.azurerm_resource_group.PortalcreatedRG.name}"
}

data "azurerm_key_vault_secret" "SecretVMPwd" {
  name      = "TerraWinVMPassword"
  vault_uri = "${data.azurerm_key_vault.PortalcreatedKeyvault.vault_uri}"
}
