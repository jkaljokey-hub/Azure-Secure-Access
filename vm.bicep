param virtualMachines_production_vm_name string = 'production-vm'
param disks_production_vm_OsDisk_1_6461a2c850de4b5eb2947afa732581ec_externalid string = '/subscriptions/c516e71f-6d47-4e41-896d-44295e620ec3/resourceGroups/production-vm_group/providers/Microsoft.Compute/disks/production-vm_OsDisk_1_6461a2c850de4b5eb2947afa732581ec'
param networkInterfaces_production_vm93_z1_externalid string = '/subscriptions/c516e71f-6d47-4e41-896d-44295e620ec3/resourceGroups/production-vm_group/providers/Microsoft.Network/networkInterfaces/production-vm93_z1'

resource virtualMachines_production_vm_name_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: virtualMachines_production_vm_name
  location: 'koreacentral'
  zones: [
    '1'
  ]
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_production_vm_name}_OsDisk_1_6461a2c850de4b5eb2947afa732581ec'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: disks_production_vm_OsDisk_1_6461a2c850de4b5eb2947afa732581ec_externalid
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_production_vm_name
      adminUsername: 'adminaqwe'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByPlatform'
          automaticByPlatformSettings: {
            rebootSetting: 'IfRequired'
          }
          assessmentMode: 'ImageDefault'
          enableHotpatching: true
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
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
          id: networkInterfaces_production_vm93_z1_externalid
          properties: {
            deleteOption: 'Detach'
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
