@description('Location for the storage account.')
param location string

@description('Globally unique storage account name.')
@maxLength(24)
param storageAccountName string

@description('Storage account SKU.')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageSku string

@description('Enable public network access for the storage account.')
param publicNetworkAccess string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageSku
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: publicNetworkAccess
    supportsHttpsTrafficOnly: true
  }
}

output storageAccountId string = storageAccount.id
output storageAccountName string = storageAccount.name
