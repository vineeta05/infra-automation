targetScope = 'subscription'
param location string
param logName string
param kvName string
param storageName string
param virtualMachineName string

resource networkRG 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  location: location
  name: 'rg-network'
}
resource monitoringRG 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  location: location
  name: 'rg-monitoring'
}
resource applicationRG 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  location: location
  name: 'rg-application'
}


module modNetwork 'network/main-network.bicep' = {
  name: 'modNetwork'
  scope: resourceGroup(networkRG.name)  
}
module modMonitoring 'monitoring/loganalytics.bicep' = {
  name: 'modMonitoring'
  scope: resourceGroup(monitoringRG.name)
  params: { 
    logName: logName
  }
}
module modStorage 'application/storage.bicep' ={
  name: 'modStorage'
  scope: resourceGroup(applicationRG.name)
  params: {storageName: storageName
  }
  
}
module modKV 'application/kv.bicep' ={
  name: 'modKV'
  scope: resourceGroup(applicationRG.name)
  params: {kvName: kvName
  }
  
}
module modVirtualMachine 'application/vm/main-vm.bicep' ={
  name: 'modVirtualMachine'
  scope:resourceGroup(applicationRG.name)
  params: {
    networkDetails: modNetwork.outputs.networkDetails
    virtualMachineName: virtualMachineName 
  }

}
