@allowed([
  'dev'
  'prod'
])
param environment string
param resourcePostfix string
param identity object

resource plan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'plan-badadvisor-${environment}-${resourcePostfix}'
  location: resourceGroup().location
  sku: {
    tier: 'Basic'
    name: 'B1'
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
    type: 'SystemAssigned'
    userAssignedIdentities: {
      id: identity
    }
  }  
}
