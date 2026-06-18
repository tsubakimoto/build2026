@description('Location for Service Bus.')
param location string

@description('Service Bus namespace name.')
param serviceBusNamespaceName string

@description('Ingress queue name.')
param ingressQueueName string

@description('Secondary queue name.')
param actionsQueueName string

resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' = {
  name: serviceBusNamespaceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    minimumTlsVersion: '1.2'
  }
}

resource ingressQueue 'Microsoft.ServiceBus/namespaces/queues@2022-10-01-preview' = {
  parent: serviceBusNamespace
  name: ingressQueueName
  properties: {
    deadLetteringOnMessageExpiration: true
    lockDuration: 'PT1M'
    maxDeliveryCount: 10
    requiresDuplicateDetection: false
  }
}

resource actionsQueue 'Microsoft.ServiceBus/namespaces/queues@2022-10-01-preview' = {
  parent: serviceBusNamespace
  name: actionsQueueName
  properties: {
    deadLetteringOnMessageExpiration: true
    lockDuration: 'PT1M'
    maxDeliveryCount: 10
    requiresDuplicateDetection: false
  }
}

output namespaceId string = serviceBusNamespace.id
output namespaceName string = serviceBusNamespace.name
output ingressQueueName string = ingressQueue.name
output actionsQueueName string = actionsQueue.name
