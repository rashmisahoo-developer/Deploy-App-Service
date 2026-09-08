@description('Application name.')
param appName string = 'testapp-x-qrcore'

@description('Deployment environment.')
param environment string

@description('Azure region.')
param location string = resourceGroup().location

module appService './modules/app-service.bicep' = {
  name: 'app-service-${environment}'
  params: {
    location: location
    appName: '${appName}-${environment}'
    appServicePlanName: '${appName}-${environment}-plan'
  }
}

output appServiceName string = appService.outputs.appServiceName
output appServicePlanName string = appService.outputs.appServicePlanName
