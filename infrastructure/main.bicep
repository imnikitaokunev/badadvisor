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
resource plan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'plan-badadvisor-${environment}-${resourcePostfix}'
  location: resourceGroup().location
  sku: {
    tier: 'Free'
    name: 'F1'
  }
  kind: 'linux'
  properties: {
    maximumElasticWorkerCount: 1
    reserved: true
  }
}

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: 'appservice-badadvisor-${environment}-${resourcePostfix}'
  location: resourceGroup().location
  properties: {
    serverFarmId: plan.id
    enabled: true
    siteConfig: {
      netFrameworkVersion: 'v5.0'
    }
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      userId: userId
    }
  }  
}
