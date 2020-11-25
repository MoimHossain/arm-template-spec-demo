

param appInsights string
param location string = resourceGroup().location
param workspaceResourceId string = ''
param resourceTags object

resource appIns 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: appInsights
  location: location
  kind: appInsights
  tags: resourceTags

  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: workspaceResourceId
  }
}

output InstrumentationKey string = appIns.properties.InstrumentationKey