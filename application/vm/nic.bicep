param networkInterfaceName string
param publicIPId string
param networkDetails object
resource nic 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: networkInterfaceName
  location: 'westeurope'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPId
            properties: {
              deleteOption: 'Delete'
            }
          }
          subnet: {
            id: networkDetails.vnetDetails.subnetFrontEndId
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkDetails.nsgId
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

output id string = nic.id
