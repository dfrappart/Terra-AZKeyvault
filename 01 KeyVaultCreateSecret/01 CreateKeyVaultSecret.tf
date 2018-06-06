######################################################
# This file add a secret in a previously deployed
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

data "azurerm_resource_group" "TerracreatedRG" {
  name = "${var.RGName}-${var.EnvironmentUsageTag}${var.EnvironmentTag}"
}

data "azurerm_key_vault" "TerracreatedKeyVault" {
  name                = "keyvaultdftest"
  resource_group_name = "${data.azurerm_resource_group.TerracreatedRG.name}"
}

data "azurerm_resource_group" "PortalcreatedRG" {
  name = "rg-001"
}

data "azurerm_key_vault" "PortalcreatedKeyvault" {
  name                = "dfkeyvaulttest02"
  resource_group_name = "${data.azurerm_resource_group.PortalcreatedRG.name}"
}

######################################################################
#Secret creation
######################################################################

module "WinVMPassword" {
  #Module location
  source = "./Modules/02 KeyvaultSecret"

  #Module variable
  PasswordName        = "WinVMPassword"
  PasswordValue       = "${var.VMAdminPassword}"
  VaultURI            = "${data.azurerm_key_vault.PortalcreatedKeyvault.vault_uri}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

module "TerraWinVMPassword" {
  #Module location
  source = "./Modules/02 KeyvaultSecret"

  #Module variable
  PasswordName        = "TerraWinVMPassword"
  PasswordValue       = "${var.VMAdminPassword}"
  VaultURI            = "${data.azurerm_key_vault.TerracreatedKeyVault.vault_uri}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}
