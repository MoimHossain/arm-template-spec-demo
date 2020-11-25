

param webAppName string
param serverFarmId string
param instrumentationKey string
param containerSpec string
param location string = resourceGroup().location

resource app 'Microsoft.Web/sites@2020-06-01' = {
  name: '${webAppName}'
  location: '${location}'
  properties: {
    httpsOnly: true
    clientAffinityEnabled: false
    serverFarmId: '${serverFarmId}'
    siteConfig: {
      linuxFxVersion: '${containerSpec}'
      appSettings:[
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {          
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: '${instrumentationKey}'
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~2'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: '${instrumentationKey}'
        }
      ]
    }
  }
}

output appId string = app.id