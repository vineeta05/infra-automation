targetScope = 'resourceGroup'

var varNsgName = 'nsg-frontend'
var varNetworkDetails = {
  vnetName: 'vnet-primary'
  vnetAddress: '10.0.0.0/16'
  snetFrontEndName: 'snet-frontend'
  snetFrontEndAddress: '10.0.0.0/24'
  snetBackEndName: 'snet-backend'
  snetBackEndAddress: '10.0.1.0/24'
}

module modNSG 'nsg.bicep' = {
  params:{nsgName: varNsgName}
}

module modVnet 'vnet.bicep' = {
  params:{
    vnetDetails: varNetworkDetails
    nsgExternalId: modNSG.outputs.id
  }
}

output networkDetails object = {
  nsgId: modNSG.outputs.id
  vnetDetails : modVnet.outputs.vnetDetails
}
