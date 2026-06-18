@description('Location for the Function App plan.')
param location string

@description('App Service plan name for Function Apps.')
param functionPlanName string

resource functionPlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: functionPlanName
  location: location
  kind: 'functionapp'
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
  properties: {
    reserved: false
  }
}

output functionPlanId string = functionPlan.id
