param environment string 
param resourcePostfix string

module storageAccount 'resources/storageAccount.bicep' = {
  name: 'storageAccount-deployment'
  params: {
    env: environment
    resourcePostfix: resourcePostfix
  }
}

module appService 'resources/appService.bicep' = {
  name: 'appService-deployment'
  params: {
    environment: environment
    resourcePostfix: resourcePostfix
    storageAccountConnection: storageAccount.outputs.connectionString
  }
}

module virtualNetwork 'resources/vnet.bicep' = {
  name: 'virtualNetwork-deployment'
  params: {
    environment: environment
    resourcePostfix: resourcePostfix
  }
}

