@description('Location for the Function App.')
param location string

@description('Function App name.')
param functionAppName string

@description('App Service plan resource ID.')
param appServicePlanId string

@description('Storage account name used by the Function App.')
param storageAccountName string

@description('Functions worker runtime.')
param workerRuntime string

@description('Application Insights connection string.')
param applicationInsightsConnectionString string

@description('Key Vault URI.')
param keyVaultUri string

@description('Service Bus namespace name.')
param serviceBusNamespaceName string

@description('Primary queue name.')
param primaryQueueName string

@description('Role of the Function App in the architecture.')
param appRole string

@description('Additional app settings.')
param extraAppSettings array = []

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
}

var azureWebJobsStorage = 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};AccountKey=${storageAccount.listKeys().keys[0].value};EndpointSuffix=${environment().suffixes.storage}'
var baseAppSettings = [
  {
    name: 'AzureWebJobsStorage'
    value: azureWebJobsStorage
  }
  {
    name: 'FUNCTIONS_EXTENSION_VERSION'
    value: '~4'
  }
  {
    name: 'FUNCTIONS_WORKER_RUNTIME'
    value: workerRuntime
  }
  {
    name: 'APPINSIGHTS_CONNECTION_STRING'
    value: applicationInsightsConnectionString
  }
  {
    name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
    value: applicationInsightsConnectionString
  }
  {
    name: 'KEY_VAULT_URI'
    value: keyVaultUri
  }
  {
    name: 'SERVICE_BUS_NAMESPACE'
    value: serviceBusNamespaceName
  }
  {
    name: 'PRIMARY_QUEUE_NAME'
    value: primaryQueueName
  }
  {
    name: 'APP_ROLE'
    value: appRole
  }
]

resource functionApp 'Microsoft.Web/sites@2023-12-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    siteConfig: {
      appSettings: concat(baseAppSettings, extraAppSettings)
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
    }
  }
}

output functionAppId string = functionApp.id
output functionAppName string = functionApp.name
output defaultHostName string = functionApp.properties.defaultHostName
output principalId string = functionApp.identity.principalId
