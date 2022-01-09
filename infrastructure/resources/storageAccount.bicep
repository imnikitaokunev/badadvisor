@allowed([
  'dev'
  'prod'
])
param environment string
param resourcePostfix string
param subnetId string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'sabadadvisor${environment}${resourcePostfix}'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      virtualNetworkRules: [
        {
          id: subnetId
          action: 'Allow'
          state: 'Succeeded'
        }
      ]
    }
  }
}



