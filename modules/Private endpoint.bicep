param privateEndpoints_EndpointConnect_name string = 'EndpointConnect'
param storageAccounts_datastorageltd_externalid string = '/subscriptions/c516e71f-6d47-4e41-896d-44295e620ec3/resourceGroups/my-Group/providers/Microsoft.Storage/storageAccounts/datastorageltd'
param virtualNetworks_myventgroup_externalid string = '/subscriptions/c516e71f-6d47-4e41-896d-44295e620ec3/resourceGroups/my-Group/providers/Microsoft.Network/virtualNetworks/myventgroup'
param privateDnsZones_privatelink_blob_core_windows_net_externalid string = '/subscriptions/c516e71f-6d47-4e41-896d-44295e620ec3/resourceGroups/my-Group/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net'

resource privateEndpoints_EndpointConnect_name_resource 'Microsoft.Network/privateEndpoints@2024-07-01' = {
  name: privateEndpoints_EndpointConnect_name
  location: 'koreacentral'
  properties: {
    privateLinkServiceConnections: [
      {
        name: privateEndpoints_EndpointConnect_name
        id: '${privateEndpoints_EndpointConnect_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_EndpointConnect_name}'
        properties: {
          privateLinkServiceId: storageAccounts_datastorageltd_externalid
          groupIds: [
            'blob'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    customNetworkInterfaceName: '${privateEndpoints_EndpointConnect_name}-nic'
    subnet: {
      id: '${virtualNetworks_myventgroup_externalid}/subnets/privte-endpoint'
    }
    ipConfigurations: []
    customDnsConfigs: []
  }
}

resource privateEndpoints_EndpointConnect_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2024-07-01' = {
  name: '${privateEndpoints_EndpointConnect_name}/default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-blob-core-windows-net'
        properties: {
          privateDnsZoneId: privateDnsZones_privatelink_blob_core_windows_net_externalid
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoints_EndpointConnect_name_resource
  ]
}
