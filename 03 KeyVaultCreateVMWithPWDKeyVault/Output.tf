######################################################
# This file defines which value are sent to output
######################################################

######################################################
# Resource group info Output

output "ResourceGroupName" {
  value = "${data.azurerm_resource_group.TerraCreatedRG.name}"
}

output "ResourceGroupId" {
  value = "${data.azurerm_resource_group.TerraCreatedRG.id}"
}

######################################################
# vNet info Output

output "vNetName" {
  value = "${data.azurerm_virtual_network.TerraCreatedVNet.name}"
}

output "vNetId" {
  value = "${data.azurerm_virtual_network.TerraCreatedVNet.id}"
}

output "vNetAddressSpace" {
  value = "${data.azurerm_virtual_network.TerraCreatedVNet.address_spaces}"
}

output "vNetDNSServers" {
  value = "${data.azurerm_virtual_network.TerraCreatedVNet.dns_servers}"
}

output "vNetDNSSubnets" {
  value = "${data.azurerm_virtual_network.TerraCreatedVNet.subnets}"
}
