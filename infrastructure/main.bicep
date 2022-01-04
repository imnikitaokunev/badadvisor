param environment string 
param resourcePostfix string

resource userId 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: 'myidentity'
  location: resourceGroup().location
}

module storageAccount 'resources/storageAccount.bicep' = {
  name: 'storageAccount-deployment'
  params: {
    environment: environment
    resourcePostfix: resourcePostfix
  }
}

module appService 'resources/appService.bicep' = {
  name: 'appService-deployment'
  params: {
    environment: environment
    resourcePostfix: resourcePostfix
    identity: userId
  }
}
