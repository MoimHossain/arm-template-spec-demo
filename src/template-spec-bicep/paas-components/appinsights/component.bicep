

param appInsights string
param location string = resourceGroup().location


resource appIns 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: '${appInsights}'
  location: '${location}'
  kind: appInsights

  properties: {
    Application_Type: 'web'
  }
}

output InstrumentationKey string = appIns.properties.InstrumentationKey