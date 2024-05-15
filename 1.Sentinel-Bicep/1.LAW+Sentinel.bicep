//  PARAM ---------------------------------------------------------------------------

param logAnalyticsWorkspaceName string

param location string = resourceGroup().location

param RetentionsInDays int = 30

// Pricing Tier array
// @allowed([
//   'CapacityReservation'
//   'Free'
//   'LACluster'
//   'PerGB2018'
//   'PerNode'
//   'Premium'
//   'Standalone'
//   'Standard'
// ])
param sku_name string = 'PerGB2018'



// Log Analytics Workspace -----------------------------------------------------------

resource LAW_Sentinel 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: {
    sku: {
      name: sku_name // pricingTier
    }
    retentionInDays: RetentionsInDays
  }
}


// Sentinel ---------------------------------------------------------------------------

resource Sentinel 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: 'SecurityInsights(${logAnalyticsWorkspaceName})'
  location: location
  properties: {
    workspaceResourceId: LAW_Sentinel.id
  }
  plan: {
    name: 'SecurityInsights(${logAnalyticsWorkspaceName})'
    product: 'OMSGallery/SecurityInsights'
    publisher: 'Microsoft'
    promotionCode: ''
  }
}


