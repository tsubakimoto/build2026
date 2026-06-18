@description('Location for Application Insights.')
param location string

@description('Application Insights resource name.')
param applicationInsightsName string

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: null
    IngestionMode: 'ApplicationInsights'
  }
}

output applicationInsightsId string = applicationInsights.id
output connectionString string = applicationInsights.properties.ConnectionString
