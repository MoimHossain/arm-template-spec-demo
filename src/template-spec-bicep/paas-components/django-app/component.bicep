param webAppName string = ''
param appInsights string = ''
param location string = resourceGroup().location
param hostingPlanName string = ''
param containerSpec string =''
param resourceTags object

module appInsightsDeployment '../appinsights/component.bicep' = {
  name: 'appInsightsDeployment'
  params:{
    appInsights: '${appInsights}'
    location: '${location}'
    resourceTags: resourceTags
  }
}

module deployHostingplan '../server-farm/component.bicep' = {
  name: 'deployHostingplan'
  params:{
    hostingPlanName:  '${hostingPlanName}'
    location: '${location}'
  }   
}

module deployWebApp '../web-app/component.bicep' = {
  name: 'deployWebApp'
  params:{
    location: '${location}'
    webAppName: '${webAppName}'
    instrumentationKey: appInsightsDeployment.outputs.InstrumentationKey
    serverFarmId: deployHostingplan.outputs.hostingPlanId
    containerSpec: '${containerSpec}'
  }   
}
