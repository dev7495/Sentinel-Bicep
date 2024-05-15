param appservice_plan_name string = '${uniqueString(resourceGroup().name)}-asp'

param appservice_name string = '${uniqueString(resourceGroup().name)}-web'

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appservice_plan_name
  location: resourceGroup().location
  sku: {
    name: 'S1'
    capacity: 1
  }
}


resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: appservice_name
  location: resourceGroup().location
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  }
  properties: {
    serverFarmId: appServicePlan.id
  }
}

