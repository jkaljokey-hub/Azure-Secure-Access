param azureFirewalls_my_firewall_product_name string = 'my-firewall-product'
param publicIPAddresses_firewall_ip_externalid string = '/subscriptions/c516e71f-6d47-4e41-896d-44295e620ec3/resourceGroups/my-Group/providers/Microsoft.Network/publicIPAddresses/firewall-ip'
param virtualNetworks_myventgroup_externalid string = '/subscriptions/c516e71f-6d47-4e41-896d-44295e620ec3/resourceGroups/my-Group/providers/Microsoft.Network/virtualNetworks/myventgroup'

resource azureFirewalls_my_firewall_product_name_resource 'Microsoft.Network/azureFirewalls@2024-07-01' = {
  name: azureFirewalls_my_firewall_product_name
  location: 'koreacentral'
  properties: {
    sku: {
      name: 'AZFW_VNet'
      tier: 'Standard'
    }
    threatIntelMode: 'Alert'
    additionalProperties: {}
    ipConfigurations: [
      {
        name: 'firewall-ip'
        id: '${azureFirewalls_my_firewall_product_name_resource.id}/azureFirewallIpConfigurations/firewall-ip'
        properties: {
          publicIPAddress: {
            id: publicIPAddresses_firewall_ip_externalid
          }
          subnet: {
            id: '${virtualNetworks_myventgroup_externalid}/subnets/AzureFirewallSubnet'
          }
        }
      }
    ]
    networkRuleCollections: []
    applicationRuleCollections: [
      {
        name: 'Allw-google'
        id: '${azureFirewalls_my_firewall_product_name_resource.id}/applicationRuleCollections/Allw-google'
        properties: {
          priority: 102
          action: {
            type: 'Allow'
          }
          rules: [
            {
              name: 'myrule'
              protocols: [
                {
                  protocolType: 'Http'
                  port: 80
                }
                {
                  protocolType: 'Https'
                  port: 443
                }
              ]
              fqdnTags: []
              targetFqdns: [
                'www.google.com'
              ]
              sourceAddresses: [
                '10.0.0.0/16'
              ]
              sourceIpGroups: []
            }
          ]
        }
      }
    ]
    natRuleCollections: []
  }
}
