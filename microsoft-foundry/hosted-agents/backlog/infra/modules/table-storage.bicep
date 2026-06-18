@description('Existing storage account name.')
param storageAccountName string

@description('Table name for idempotency records.')
param tableName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
}

resource tableService 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storageAccount
  name: 'default'
}

resource table 'Microsoft.Storage/storageAccounts/tableServices/tables@2023-05-01' = {
  parent: tableService
  name: tableName
}

output tableName string = table.name
output tableEndpoint string = 'https://${storageAccount.name}.table.${environment().suffixes.storage}'
