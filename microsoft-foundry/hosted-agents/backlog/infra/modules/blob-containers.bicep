@description('Existing storage account name.')
param storageAccountName string

@description('Blob containers to create.')
param blobContainers array

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccount
  name: 'default'
}

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = [for containerName in blobContainers: {
  parent: blobService
  name: containerName
  properties: {
    publicAccess: 'None'
  }
}]

output blobEndpoint string = 'https://${storageAccount.name}.blob.${environment().suffixes.storage}'
