param environment string 
param resourcePostfix string

module vNet 'resources/vnet.bicep' = {
  name: 'vnet-deployment'
  params: {
    environment: environment
    resourcePostfix: resourcePostfix
  }
}

module storageAccount 'resources/storageAccount.bicep' = {
  name: 'storageAccount-deployment'
  params: {
    environment: environment
    resourcePostfix: resourcePostfix
    subnetId: vNet.outputs.subnetId
  }
}

module appService 'resources/appService.bicep' = {
  name: 'appService-deployment'
  params: {
    environment: environment
    resourcePostfix: resourcePostfix

  }
}
