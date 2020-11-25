param location string = resourceGroup().location
param hostingPlanName string

resource hosting 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: '${hostingPlanName}'
  location: '${location}'
  kind: 'linux'
  sku: {
    tier: 'Free'
    name: 'F1'
  }
  properties: {
    reserved: true
    targetWorkerCount: 1
  }
}

output hostingPlanId string = hosting.id