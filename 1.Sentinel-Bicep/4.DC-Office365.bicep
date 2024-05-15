// Reference - https://learn.microsoft.com/en-us/azure/templates/microsoft.securityinsights/dataconnectors?pivots=deployment-language-bicep
// - Office365

//  PARAM ---------------------------------------------------------------------------
param logAnalyticsWorkspaceName string

param location string = resourceGroup().location

param RetentionsInDays int = 30

param sku_name string = 'PerGB2018'

param dataState_Enabled string = 'Enabled'

param tenant_id string = '40c986a0-6b01-47a2-bc81-405e7fa011a7'

// Log Analytics Workspace -----------------------------------------------------------
resource LAW_Sentinel 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: {
    sku: {
      name: sku_name // pricingTier
    }
    retentionInDays: RetentionsInDays
}}


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
}}


// Data Connector - AzureSecurityCenter --------------------------------------------------------
resource DC_AzureSecurityCenter 'Microsoft.SecurityInsights/dataConnectors@2024-03-01' = {
  name:  '${logAnalyticsWorkspaceName}-Office365' 
  scope: resource.DC_Azure
  kind: 'Office365'
  properties: {
    dataTypes: {
      exchange: {
        state: dataState_Enabled
      }
      sharePoint: {
        state: dataState_Enabled
      }
      teams: {
        state: dataState_Enabled
      }
    }
    tenantId: tenant_id
  }}

