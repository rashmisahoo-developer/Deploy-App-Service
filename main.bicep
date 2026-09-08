param location string = resourceGroup().location
param appName string
param environment string

module appServicePlan './modules/app-service-plan.bicep' = {
  name: 'app-service-plan'
  params: {
    location: location
    planName: '${appName}-${environment}-plan'
  }
}

module appService './modules/app-service.bicep' = {
  name: 'app-service'
  params: {
    location: location
    appName: '${appName}-${environment}'
    appServicePlanId: appServicePlan.outputs.planId
  }
}
