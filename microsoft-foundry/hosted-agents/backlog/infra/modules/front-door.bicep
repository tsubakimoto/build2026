@description('Front Door profile name.')
param frontDoorProfileName string

@description('Front Door endpoint name.')
param frontDoorEndpointName string

@description('Front Door origin group name.')
param frontDoorOriginGroupName string

@description('Front Door origin name.')
param frontDoorOriginName string

@description('Front Door route name.')
param frontDoorRouteName string

@description('Origin host name for the receiver Function App.')
param originHostName string

resource profile 'Microsoft.Cdn/profiles@2024-02-01' = {
  name: frontDoorProfileName
  location: 'global'
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
}

resource endpoint 'Microsoft.Cdn/profiles/afdEndpoints@2024-02-01' = {
  parent: profile
  name: frontDoorEndpointName
  location: 'global'
  properties: {
    enabledState: 'Enabled'
  }
}

resource originGroup 'Microsoft.Cdn/profiles/originGroups@2024-02-01' = {
  parent: profile
  name: frontDoorOriginGroupName
  properties: {
    healthProbeSettings: {
      probePath: '/api/health'
      probeProtocol: 'Https'
      probeRequestType: 'GET'
      probeIntervalInSeconds: 120
    }
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
    sessionAffinityState: 'Disabled'
  }
}

resource origin 'Microsoft.Cdn/profiles/originGroups/origins@2024-02-01' = {
  parent: originGroup
  name: frontDoorOriginName
  properties: {
    enabledState: 'Enabled'
    hostName: originHostName
    httpPort: 80
    httpsPort: 443
    originHostHeader: originHostName
    priority: 1
    weight: 1000
    enforceCertificateNameCheck: true
  }
}

resource route 'Microsoft.Cdn/profiles/afdEndpoints/routes@2024-02-01' = {
  parent: endpoint
  name: frontDoorRouteName
  properties: {
    enabledState: 'Enabled'
    forwardingProtocol: 'HttpsOnly'
    httpsRedirect: 'Enabled'
    linkToDefaultDomain: 'Enabled'
    originGroup: {
      id: originGroup.id
    }
    patternsToMatch: [
      '/api/*'
    ]
    supportedProtocols: [
      'Http'
      'Https'
    ]
  }
}

output profileId string = profile.id
output endpointHostName string = endpoint.properties.hostName
