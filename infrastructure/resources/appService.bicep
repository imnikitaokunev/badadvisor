param environment string
param resourcePostfix string
param location string = resourceGroup().location
@secure()
param storageAccountConnection string
param vnetName string
param subnetId string

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: 'appservice-badadvisor-${environment}-${resourcePostfix}'
  location: location
  properties: {
    serverFarmId: plan.id
    enabled: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|5.0'
      alwaysOn: true
      vnetName: vnetName
      vnetRouteAllEnabled: true
      appSettings: [
        {
          name: 'StorageConnectionString'
          value: storageAccountConnection
        }
      ]
    }
    virtualNetworkSubnetId: subnetId
  }
}

resource plan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'plan-badadvisor-${environment}-${resourcePostfix}'
  location: location
  sku: {
    tier: 'Standard'
    name: 'S1'
  }
  kind: 'linux'
  properties: {
    maximumElasticWorkerCount: 1
    reserved: true
  }
}
