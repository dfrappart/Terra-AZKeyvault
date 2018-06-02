##############################################################
#This file creates Windows VM
##############################################################

#Availability set creation

module "AS_SampleVM" {
  #Module source

  #source = "./Modules/AvailabilitySet"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//13 AvailabilitySet"

  #Module variables
  ASName              = "AS_SampleVM"
  RGName              = "${module.ResourceGroup.Name}"
  ASLocation          = "${var.AzureRegion}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

#FE public IP Creation

module "SampleVMIP" {
  #Module source
  #source = "./Modules/10 PublicIP"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//10 PublicIP"

  #Module variables
  PublicIPCount       = "1"
  PublicIPName        = "samplevmip"
  PublicIPLocation    = "${var.AzureRegion}"
  RGName              = "${module.ResourceGroup.Name}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

#NIC Creation

module "NICs_SampleVM" {
  #module source

  #source = "./Modules/12 NICwithPIPWithCount"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//12 NICwithPIPWithCount"

  #Module variables

  NICName             = "NIC_SampleVM"
  NICLocation         = "${var.AzureRegion}"
  RGName              = "${module.ResourceGroup.Name}"
  SubnetId            = "${module.FE_Subnet.Id}"
  PublicIPId          = ["${module.SampleVMIP.Ids}"]
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

#Datadisk creation

module "DataDisks_SampleVM" {
  #Module source

  #source = "./Modules/06 ManagedDiskswithcount"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//06 ManagedDiskswithcount"

  #Module variables

  ManageddiskName     = "DataDisk_SampleVM"
  RGName              = "${module.ResourceGroup.Name}"
  ManagedDiskLocation = "${var.AzureRegion}"
  StorageAccountType  = "${lookup(var.Manageddiskstoragetier, 0)}"
  CreateOption        = "Empty"
  DiskSizeInGB        = "63"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

#VM creation

#Data source for VM Password in keyvault

data "azurerm_key_vault_secret" "VMPassword" {
  name      = "${module.WinVMPassword.Name}"
  vault_uri = "${module.Keyvault.URI}"
}

module "VMs_SampleVM" {
  #module source

  source = "github.com/dfrappart/Terra-AZCloudInit//Modules//02 WinVMWithCount"

  #Module variables

  VMName              = "SampleVM"
  VMLocation          = "${var.AzureRegion}"
  VMRG                = "${module.ResourceGroup.Name}"
  VMNICid             = ["${module.NICs_SampleVM.Ids}"]
  VMSize              = "${lookup(var.VMSize, 5)}"
  ASID                = "${module.AS_SampleVM.Id}"
  VMStorageTier       = "${lookup(var.Manageddiskstoragetier, 0)}"
  VMAdminName         = "${var.VMAdminName}"
  VMAdminPassword     = "${data.azurerm_key_vault_secret.VMPassword.value}"
  DataDiskId          = ["${module.DataDisks_SampleVM.Ids}"]
  DataDiskName        = ["${module.DataDisks_SampleVM.Names}"]
  DataDiskSize        = ["${module.DataDisks_SampleVM.Sizes}"]
  VMPublisherName     = "${lookup(var.PublisherName, 0)}"
  VMOffer             = "${lookup(var.Offer, 0)}"
  VMsku               = "${lookup(var.sku, 0)}"
  DiagnosticDiskURI   = "${module.DiagStorageAccount.PrimaryBlobEP}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
  CloudinitscriptPath = "./Scripts/example.ps1"
}

#VM Agent
/*
module "CustomExtensionWinForCloudInit" {
  #Module location
  source = "./Modules/03 CustomLinuxExtensionScriptwithtpl"

  #Module variables

  AgentName            = "CustomExtensionWinForCloudInit"
  AgentLocation        = "${var.AzureRegion}"
  AgentRG              = "${module.ResourceGroup.Name}"
  VMName               = ["${module.VMs_CloudInitWin.Name}"]
  EnvironmentTag       = "${var.EnvironmentTag}"
  EnvironmentUsageTag  = "${var.EnvironmentUsageTag}"
  AgentPublisher       = "microsoft.compute"
  AgentType            = "customscriptextension"
  Agentversion         = "1.9"
  SettingsTemplatePath = "./Templates/CloudInitwin.tpl"
}

*/

#Network Watcher Agent

module "NetworkWatcherAgentForCloudInitWin" {
  #Module Location
  #source = "./Modules/NetworkWatcherAgentWin"
  source = "github.com/dfrappart/Terra-AZBasicWinWithModules//Modules//NetworkWatcherAgentWin"

  #Module variables

  AgentName           = "NetworkWatcherAgentForSampleVM"
  AgentLocation       = "${var.AzureRegion}"
  AgentRG             = "${module.ResourceGroup.Name}"
  VMName              = ["${module.VMs_SampleVM.Name}"]
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}