param bastionHosts_BastionConnection_name string = 'BastionConnection'
param publicIPAddresses_myventgroup_IPv4_externalid string = '/subscriptions/c516e71f-6d47-4e41-896d-44295e620ec3/resourceGroups/production-vm_group/providers/Microsoft.Network/publicIPAddresses/myventgroup-IPv4'
param virtualNetworks_myventgroup_externalid string = '/subscriptions/c516e71f-6d47-4e41-896d-44295e620ec3/resourceGroups/my-Group/providers/Microsoft.Network/virtualNetworks/myventgroup'

resource bastionHosts_BastionConnection_name_resource 'Microsoft.Network/bastionHosts@2024-07-01' = {
  name: bastionHosts_BastionConnection_name
  location: 'koreacentral'
  sku: {
    name: 'Standard'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    dnsName: 'bst-cf2ea5a3-4d1e-4cfe-866d-230e09d03bc9.bastion.azure.com'
    scaleUnits: 2
    enableTunneling: false
    enableIpConnect: false
    disableCopyPaste: false
    enableShareableLink: false
    enableKerberos: false
    enableSessionRecording: false
    enablePrivateOnlyBastion: false
    ipConfigurations: [
      {
        name: 'IpConf'
        id: '${bastionHosts_BastionConnection_name_resource.id}/bastionHostIpConfigurations/IpConf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_myventgroup_IPv4_externalid
          }
          subnet: {
            id: '${virtualNetworks_myventgroup_externalid}/subnets/AzureBastionSubnet'
          }
        }
      }
    ]
  }
}
