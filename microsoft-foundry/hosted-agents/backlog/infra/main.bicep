@description('Location for all resources.')
param location string = resourceGroup().location

@description('Suffix for the storage account name. Lowercase alphanumeric only.')
@minLength(1)
@maxLength(22)
param storageAccountSuffix string

@description('Storage account SKU.')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageSku string = 'Standard_LRS'

@description('Enable public network access for the storage account.')
param publicNetworkAccess string = 'Enabled'

@description('Table name for idempotency records.')
param tableName string = 'backlogidempotency'

@description('Blob containers to create in the same storage account for webhook operations.')
param blobContainers array = [
  'backlog-webhook-raw'
  'backlog-agent-results'
  'backlog-agent-dlq'
]

@description('Suffix for the Application Insights name.')
param applicationInsightsSuffix string

@description('Suffix for the Key Vault name.')
param keyVaultSuffix string

@description('Suffix for the Service Bus namespace name.')
param serviceBusNamespaceSuffix string

@description('Ingress queue name.')
param ingressQueueName string = 'backlog-webhook-ingress'

@description('Dead-letter or follow-up queue name.')
param actionsQueueName string = 'backlog-agent-actions'

@description('Suffix for the Function App plan name.')
param functionPlanSuffix string

@description('Suffix for the receiver Function App name.')
param receiverFunctionAppSuffix string

@description('Suffix for the worker Function App name.')
param workerFunctionAppSuffix string

@description('Functions worker runtime.')
param functionsWorkerRuntime string = 'dotnet-isolated'

@description('Suffix for the Front Door profile name.')
param frontDoorProfileSuffix string

@description('Suffix for the Front Door endpoint name.')
param frontDoorEndpointSuffix string

var abbreviations = loadJsonContent('abbreviations.json')
var storagePrefix = string(abbreviations.storageStorageAccounts)
var appInsightsPrefix = string(abbreviations.insightsComponents)
var keyVaultPrefix = string(abbreviations.keyVaultVaults)
var serviceBusPrefix = string(abbreviations.serviceBusNamespaces)
var functionPlanPrefix = string(abbreviations.webServerFarms)
var functionAppPrefix = string(abbreviations.webSitesFunctions)
var frontDoorPrefix = string(abbreviations.networkFrontDoors)

var storageAccountName = toLower('${storagePrefix}${storageAccountSuffix}')
var applicationInsightsName = toLower('${appInsightsPrefix}${applicationInsightsSuffix}')
var keyVaultName = toLower('${keyVaultPrefix}${keyVaultSuffix}')
var serviceBusNamespaceName = toLower('${serviceBusPrefix}${serviceBusNamespaceSuffix}')
var functionPlanName = toLower('${functionPlanPrefix}${functionPlanSuffix}')
var receiverFunctionAppName = toLower('${functionAppPrefix}${receiverFunctionAppSuffix}')
var workerFunctionAppName = toLower('${functionAppPrefix}${workerFunctionAppSuffix}')
var frontDoorProfileName = toLower('${frontDoorPrefix}${frontDoorProfileSuffix}')
var frontDoorEndpointName = toLower('${frontDoorPrefix}${frontDoorEndpointSuffix}')
var frontDoorOriginGroupName = toLower('${frontDoorPrefix}${frontDoorEndpointSuffix}-og')
var frontDoorOriginName = toLower('${frontDoorPrefix}${frontDoorEndpointSuffix}-origin')
var frontDoorRouteName = toLower('${frontDoorPrefix}${frontDoorEndpointSuffix}-route')

module storageAccountModule './modules/storage-account.bicep' = {
  name: 'storageAccount'
  params: {
    location: location
    storageAccountName: storageAccountName
    storageSku: storageSku
    publicNetworkAccess: publicNetworkAccess
  }
}

module blobContainersModule './modules/blob-containers.bicep' = {
  name: 'blobContainers'
  params: {
    storageAccountName: storageAccountModule.outputs.storageAccountName
    blobContainers: blobContainers
  }
}

module tableStorageModule './modules/table-storage.bicep' = {
  name: 'tableStorage'
  params: {
    storageAccountName: storageAccountModule.outputs.storageAccountName
    tableName: tableName
  }
}

module applicationInsightsModule './modules/application-insights.bicep' = {
  name: 'applicationInsights'
  params: {
    location: location
    applicationInsightsName: applicationInsightsName
  }
}

module keyVaultModule './modules/key-vault.bicep' = {
  name: 'keyVault'
  params: {
    location: location
    keyVaultName: keyVaultName
  }
}

module serviceBusModule './modules/service-bus.bicep' = {
  name: 'serviceBus'
  params: {
    location: location
    serviceBusNamespaceName: serviceBusNamespaceName
    ingressQueueName: ingressQueueName
    actionsQueueName: actionsQueueName
  }
}

module functionPlanModule './modules/function-plan.bicep' = {
  name: 'functionPlan'
  params: {
    location: location
    functionPlanName: functionPlanName
  }
}

module receiverFunctionAppModule './modules/function-app.bicep' = {
  name: 'receiverFunctionApp'
  params: {
    location: location
    functionAppName: receiverFunctionAppName
    appServicePlanId: functionPlanModule.outputs.functionPlanId
    storageAccountName: storageAccountModule.outputs.storageAccountName
    workerRuntime: functionsWorkerRuntime
    applicationInsightsConnectionString: applicationInsightsModule.outputs.connectionString
    keyVaultUri: keyVaultModule.outputs.vaultUri
    serviceBusNamespaceName: serviceBusModule.outputs.namespaceName
    primaryQueueName: serviceBusModule.outputs.ingressQueueName
    appRole: 'receiver'
    extraAppSettings: [
      {
        name: 'IDEMPOTENCY_TABLE_NAME'
        value: tableStorageModule.outputs.tableName
      }
      {
        name: 'RAW_PAYLOAD_CONTAINER'
        value: 'backlog-webhook-raw'
      }
    ]
  }
}

module workerFunctionAppModule './modules/function-app.bicep' = {
  name: 'workerFunctionApp'
  params: {
    location: location
    functionAppName: workerFunctionAppName
    appServicePlanId: functionPlanModule.outputs.functionPlanId
    storageAccountName: storageAccountModule.outputs.storageAccountName
    workerRuntime: functionsWorkerRuntime
    applicationInsightsConnectionString: applicationInsightsModule.outputs.connectionString
    keyVaultUri: keyVaultModule.outputs.vaultUri
    serviceBusNamespaceName: serviceBusModule.outputs.namespaceName
    primaryQueueName: serviceBusModule.outputs.ingressQueueName
    appRole: 'worker'
    extraAppSettings: [
      {
        name: 'IDEMPOTENCY_TABLE_NAME'
        value: tableStorageModule.outputs.tableName
      }
      {
        name: 'RESULTS_CONTAINER'
        value: 'backlog-agent-results'
      }
      {
        name: 'DLQ_CONTAINER'
        value: 'backlog-agent-dlq'
      }
      {
        name: 'ACTIONS_QUEUE_NAME'
        value: serviceBusModule.outputs.actionsQueueName
      }
    ]
  }
}

module frontDoorModule './modules/front-door.bicep' = {
  name: 'frontDoor'
  params: {
    frontDoorProfileName: frontDoorProfileName
    frontDoorEndpointName: frontDoorEndpointName
    frontDoorOriginGroupName: frontDoorOriginGroupName
    frontDoorOriginName: frontDoorOriginName
    frontDoorRouteName: frontDoorRouteName
    originHostName: receiverFunctionAppModule.outputs.defaultHostName
  }
}

output storageAccountId string = storageAccountModule.outputs.storageAccountId
output storageAccountNameOut string = storageAccountModule.outputs.storageAccountName
output tableNameOut string = tableStorageModule.outputs.tableName
output tableEndpoint string = tableStorageModule.outputs.tableEndpoint
output blobEndpoint string = blobContainersModule.outputs.blobEndpoint
output applicationInsightsConnectionString string = applicationInsightsModule.outputs.connectionString
output keyVaultUri string = keyVaultModule.outputs.vaultUri
output serviceBusNamespaceNameOut string = serviceBusModule.outputs.namespaceName
output ingressQueueNameOut string = serviceBusModule.outputs.ingressQueueName
output actionsQueueNameOut string = serviceBusModule.outputs.actionsQueueName
output applicationInsightsNameOut string = applicationInsightsName
output keyVaultNameOut string = keyVaultName
output functionPlanNameOut string = functionPlanName
output receiverFunctionAppNameOut string = receiverFunctionAppName
output workerFunctionAppNameOut string = workerFunctionAppName
output frontDoorProfileNameOut string = frontDoorProfileName
output frontDoorEndpointNameOut string = frontDoorEndpointName
output receiverFunctionDefaultHostName string = receiverFunctionAppModule.outputs.defaultHostName
output workerFunctionDefaultHostName string = workerFunctionAppModule.outputs.defaultHostName
output frontDoorEndpointHostName string = frontDoorModule.outputs.endpointHostName
