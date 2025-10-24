param kvName string

resource keyVault 'Microsoft.KeyVault/vaults@2024-12-01-preview' = {
  name: kvName
  location: resourceGroup().location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    accessPolicies:[]
  }
}




