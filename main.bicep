targetScope = 'subscription'
param location string
param kvName string
param storageName string

resource applicationRG 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  location: location
  name: 'rg-application'
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

