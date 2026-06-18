@description('Location for Key Vault.')
param location string

@description('Key Vault name.')
param keyVaultName string

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    enableRbacAuthorization: true
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    softDeleteRetentionInDays: 90
  }
}

output keyVaultId string = keyVault.id
output vaultUri string = keyVault.properties.vaultUri
