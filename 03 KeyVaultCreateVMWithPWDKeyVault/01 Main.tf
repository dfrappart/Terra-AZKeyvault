######################################################
# This file get a secret in a previously deployed
# keyvault and use the value to populate the VM 
#Password Value
######################################################

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

data "azurerm_resource_group" "TerraCreatedRG" {
  name = "${var.RGName}-${var.EnvironmentUsageTag}${var.EnvironmentTag}"
}

data "azurerm_key_vault" "TerraCreatedKeyVault" {
  name                = "keyvaultdftest"
  resource_group_name = "${data.azurerm_resource_group.TerraCreatedRG.name}"
}

data "azurerm_resource_group" "PortalcreatedRG" {
  name = "rg-001"
}

data "azurerm_key_vault" "PortalcreatedKeyvault" {
  name                = "dfkeyvaulttest02"
  resource_group_name = "${data.azurerm_resource_group.PortalcreatedRG.name}"
}

data "azurerm_virtual_network" "TerraCreatedVNet" {
  name                = "${var.vNetName}${var.EnvironmentUsageTag}${var.EnvironmentTag}"
  resource_group_name = "${data.azurerm_resource_group.TerraCreatedRG.name}"
}

data "azurerm_network_security_group" "TerraCreatedBastionNSG" {
  name                = "NSG_${lookup(var.SubnetName, 2)}"
  resource_group_name = "${data.azurerm_resource_group.TerraCreatedRG.name}"
}

data "azurerm_subnet" "TerraCreatedBastionSubnet" {
  name                 = "${lookup(var.SubnetName, 2)}"
  virtual_network_name = "${data.azurerm_virtual_network.TerraCreatedVNet.name}"
  resource_group_name  = "${data.azurerm_resource_group.TerraCreatedRG.name}"
}

#Data source for VM Password in keyvault

data "azurerm_key_vault_secret" "VMPassword" {
  name      = "DefaultVMPassword"
  vault_uri = "${data.azurerm_key_vault.PortalcreatedKeyvault.vault_uri}"
}

#Data source for diagnostic storage account

data "azurerm_storage_account" "SourceSTOADiagLog" {
  name                = "stoakeyvaulttestlog"
  resource_group_name = "${data.azurerm_resource_group.TerraCreatedRG.name}"
}
