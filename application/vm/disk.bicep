param diskName string

resource disk 'Microsoft.Compute/disks@2024-03-02' = {
  name: diskName
  location: 'westeurope'
  sku: {
    name: 'StandardSSD_LRS'
  }
  properties: {
    osType: 'Linux'
    hyperVGeneration: 'V2'
    supportsHibernation: true
    supportedCapabilities: {
      diskControllerTypes: 'SCSI, NVMe'
      acceleratedNetwork: true
      architecture: 'x64'
    }
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: 30
    diskIOPSReadWrite: 500
    diskMBpsReadWrite: 100
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
    securityProfile: {
      securityType: 'TrustedLaunch'
    }
    publicNetworkAccess: 'Enabled'
  }
}

output id string = disk.id
output name string = disk.name
