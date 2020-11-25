param webAppName string = ''
param appInsights string = ''
param location string = resourceGroup().location
param hostingPlanName string = ''
param containerSpec string =''
param costCenter string
param environment string

module appInsightsDeployment '../appinsights/component.bicep' = {
  name: 'appInsightsDeployment'
  params:{
    appInsights: '${appInsights}'
    location: '${location}'
    costCenter: costCenter
    environment: environment
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
