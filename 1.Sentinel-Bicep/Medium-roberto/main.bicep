// param workspaceName string

// @allowed ([
//   'PerGB2018'
//   'Free'
//   'Standalone'
//   'PerNode'
//   'Standard'
//   'Premium'
// ])
// param pricingTier string = 'PerGB2018'


// @minValue(7)
// @maxValue(30)
// param dataRetention int = 30


param location string = resourceGroup().location



// // Creats Log analytics workspace
// resource workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
//   name: workspaceName // must be globally unique
//   location: location
//   properties: {
//     sku: {
//         name: pricingTier
//     }
//     // retentionInDays: 30
//     // features: {
//     //     immediatePurgeDataOn30Days: true
//     // }
//   }
// }


// Using existing Log Analytics workspace
resource LAW_Sentinel3 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  name: 'LAW-Sentinel3'
}


// Creates / Links Sentinel with Log Analytics Workspace
resource Sentinel 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: 'SecurityInsights(${LAW_Sentinel3.name})'
  location: location
  properties: {
      workspaceResourceId: LAW_Sentinel3.id
  }
  plan: {
      name: 'SecurityInsights(${LAW_Sentinel3.name})'
      product: 'OMSGallery/SecurityInsights'
      publisher: 'Microsoft'
      promotionCode: ''
  }
}

