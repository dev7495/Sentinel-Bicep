// Reference - https://www.jorgebernhardt.com/bicep-microsoft-sentinel/
// To integrate with Microsoft Entra ID make sure you have:
// - Workspace: read and write permissions.
// - Diagnostic Settings: read and write permissions to Microsoft Entra ID diagnostic settings.
// - Tenant Permissions: 'Global Administrator' or 'Security Administrator' on the workspace's tenant.

//  PARAM ---------------------------------------------------------------------------
param logAnalyticsWorkspaceName string

param location string = resourceGroup().location

param RetentionsInDays int = 30

param sku_name string = 'PerGB2018'

param dataState_Enabled string = 'Enabled'

param dataConnectors_kind string = 'AzureActiveDirectory'

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


// Data Connector - Azure Active Directory --------------------------------------------------------
resource azure_AD_DataConnector 'Microsoft.SecurityInsights/dataConnectors@2023-02-01-preview' = {
  name: '${logAnalyticsWorkspaceName}-Azure_Active_Directory'
  kind:  dataConnectors_kind
  scope: LAW_Sentinel
  dependsOn: [
    Sentinel
]
  properties: {
    dataTypes: {
      alerts: {
        state: dataState_Enabled
      }
    }
    tenantId: tenant_id
  }}
