param virtualMachineName string
param disksName string
param networkInterfaceId string
param adminUserName string



resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: virtualMachineName
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1ls'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: disksName
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachineName
      adminUsername: adminUserName
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${adminUserName}/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2rOz4mCjwQjTwd20W48cdpR0xlLEgL/UvRCFT52A2zG05XuBQIj6OiSrt2vytSIOguXEAJmcOwQ/Yr3AL+a577MhYYDU7XybmAfGhgIj88DW6Txe/tYUv7rRqwcqWVgWWOnWEtWBowL64lo50ED5Q4pFTYUf9Ef1xL+8zdzbBT01Dure/UVm4UTa8fQxL+2WZ3nrMdZoFGEjUj4ygVcoubCHxqjLA3/tXXNKXeOsEBRo8/cExCZkklJxrpZtBgViS/xs0kd8CgAomQmGq5d4q+V0O7UpEXlfKsIPwKkWkgQ3QCO3AUpPEncPmsZIpeK1eKUwLDuvNW9nTRX5Uysjec+WSnRkr0PzRxUx/MpPQH9w2NfjTrEizYQ1DLEzrjBasKQA0nKnSsnX7/hK6JncPY6/OU+k+svuxqrP0uUsdP1zvYF9c0znhegqBkEYiVjJDfgroFxcq4Qe83COMO+06DmlBo3xblgqjZM6L0kat1HpFvaCV9PI5eq5qGS5yROU= generated-by-azure'
            }
          ]
        }
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      //requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaceId
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}
