param virtualNetworks_myventgroup_name string = 'myventgroup'
param routeTables_route_resourse_externalid string = '/subscriptions/c516e71f-6d47-4e41-896d-44295e620ec3/resourceGroups/my-Group/providers/Microsoft.Network/routeTables/route-resourse'

resource virtualNetworks_myventgroup_name_resource 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: virtualNetworks_myventgroup_name
  location: 'koreacentral'
  tags: {
    bakry: 'myvent'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'AzureFirewallSubnet'
        id: virtualNetworks_myventgroup_name_AzureFirewallSubnet.id
        properties: {
          addressPrefixes: [
            '10.0.1.64/26'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'default'
        id: virtualNetworks_myventgroup_name_default.id
        properties: {
          addressPrefixes: [
            '10.0.0.0/24'
          ]
          routeTable: {
            id: routeTables_route_resourse_externalid
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'privte-endpoint'
        id: virtualNetworks_myventgroup_name_privte_endpoint.id
        properties: {
          addressPrefixes: [
            '10.0.3.0/24'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'AzureBastionSubnet'
        id: virtualNetworks_myventgroup_name_AzureBastionSubnet.id
        properties: {
          addressPrefixes: [
            '10.0.2.0/26'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualNetworks_myventgroup_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_myventgroup_name}/AzureBastionSubnet'
  properties: {
    addressPrefixes: [
      '10.0.2.0/26'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_myventgroup_name_resource
  ]
}

resource virtualNetworks_myventgroup_name_AzureFirewallSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_myventgroup_name}/AzureFirewallSubnet'
  properties: {
    addressPrefixes: [
      '10.0.1.64/26'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_myventgroup_name_resource
  ]
}

resource virtualNetworks_myventgroup_name_default 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_myventgroup_name}/default'
  properties: {
    addressPrefixes: [
      '10.0.0.0/24'
    ]
    routeTable: {
      id: routeTables_route_resourse_externalid
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_myventgroup_name_resource
  ]
}

resource virtualNetworks_myventgroup_name_privte_endpoint 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_myventgroup_name}/privte-endpoint'
  properties: {
    addressPrefixes: [
      '10.0.3.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_myventgroup_name_resource
  ]
}
