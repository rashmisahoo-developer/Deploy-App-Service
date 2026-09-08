@description('Azure region where the resources will be deployed.')
param location string = resourceGroup().location

@description('Name of the App Service.')
param appName string

@description('Name of the App Service Plan.')
param appServicePlanName string

@description('App Service Plan SKU.')
param skuName string = 'B1'

@description('App Service Plan SKU tier.')
param skuTier string = 'Basic'

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location

  sku: {
    name: skuName
    tier: skuTier
  }

  kind: 'app'
}

resource appService 'Microsoft.Web/sites@2024-04-01' = {
  name: appName
  location: location

  properties: {
    serverFarmId: appServicePlan.id

    httpsOnly: true

    siteConfig: {
      alwaysOn: true

      appSettings: [
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
    }
  }

  identity: {
    type: 'SystemAssigned'
  }
}

output appServiceName string = appService.name
output appServicePlanName string = appServicePlan.name
output appServiceId string = appService.id
output appServicePlanId string = appServicePlan.id
