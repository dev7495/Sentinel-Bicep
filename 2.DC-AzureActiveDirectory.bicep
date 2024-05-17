// Reference - https://www.jorgebernhardt.com/bicep-microsoft-sentinel/
// To integrate with Microsoft Entra ID make sure you have:
// - Workspace: read and write permissions.
// - Diagnostic Settings: read and write permissions to Microsoft Entra ID diagnostic settings.
// - Tenant Permissions: 'Global Administrator' or 'Security Administrator' on the workspace's tenant.

//  PARAM ---------------------------------------------------------------------------
param logAnalyticsWorkspaceName string = 'LAW-Sentinel'

param dataState_Enabled string = 'Enabled'

param tenant_id string = '40c986a0-6b01-47a2-bc81-405e7fa011a7'


// Log Analytics Workspace -----------------------------------------------------------
resource LAW_Sentinel 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  name: logAnalyticsWorkspaceName
}


// Sentinel ---------------------------------------------------------------------------
resource Sentinel 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' existing = {
  name: logAnalyticsWorkspaceName
}  


// Data Connector - Azure Active Directory --------------------------------------------------------
resource DC_AzureActiveDirectory 'Microsoft.SecurityInsights/dataConnectors@2023-02-01-preview' = {
  name: '${logAnalyticsWorkspaceName}-AzureActiveDirectory'
  kind: 'AzureActiveDirectory'
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
