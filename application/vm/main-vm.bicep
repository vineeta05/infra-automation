targetScope = 'resourceGroup'
param networkDetails object
param virtualMachineName string

//Resources name
var varPublicIPName = 'pip-vm-${virtualMachineName}'

module modPublicIP 'publicIP.bicep' = {
  name: 'modPublicIP'
  params:{publicIPName: varPublicIPName}
}

module modNetworkInterface 'nic.bicep' = {
  name: 'modNetworkInterface'
  params:{
    networkDetails: networkDetails
    publicIPId: modPublicIP.outputs.id
    networkInterfaceName: 'nic-vm-${virtualMachineName}'
  }
}
/*module modDisk 'disk.bicep'={
  name: 'modDisk'
  params:{diskName:'disk-${virtualMachineName}'}}*/

module modVM 'vm.bicep' =  {
  name: 'modVM'
  params: {
    adminUserName: 'lernia-admin'
    disksName: 'disk-${virtualMachineName}'
    networkInterfaceId: modNetworkInterface.outputs.id
    virtualMachineName: virtualMachineName
  }
}


