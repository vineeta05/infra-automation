param publicIPName string
resource publicIPAddresses_pip_vm_virtualmachine1_name_resource 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: publicIPName
  location: resourceGroup().location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

output id string = publicIPAddresses_pip_vm_virtualmachine1_name_resource.id
