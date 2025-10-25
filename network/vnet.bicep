targetScope = 'resourceGroup'
param vnetDetails object
param nsgExternalId string

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetDetails.vnetName
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetDetails.vnetAddress
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource subnetBackEnd 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: vnet
  name: vnetDetails.snetBackEndName
  properties: {
    addressPrefixes: [
      vnetDetails.snetBackEndAddress
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }  
}

resource subnetFrontEnd 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: vnet
  name: vnetDetails.snetFrontEndName
  properties: {
    addressPrefixes: [
      vnetDetails.snetFrontEndAddress
    ]
    networkSecurityGroup: {
      id: nsgExternalId
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

output vnetDetails object = {
  vnetName: vnet.name
  vnetId: vnet.id
  subnetFrontEndName: subnetFrontEnd.name
  subnetFrontEndId: subnetFrontEnd.id
  subnetBackEndName: subnetBackEnd.name
  subnetBackEndId: subnetBackEnd.id
}
 



