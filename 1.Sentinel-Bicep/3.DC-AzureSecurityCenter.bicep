// Reference - https://learn.microsoft.com/en-us/azure/templates/microsoft.securityinsights/dataconnectors?pivots=deployment-language-bicep
// - AzureSecurityCenter

//  PARAM ---------------------------------------------------------------------------
param logAnalyticsWorkspaceName string = 'LAW-Sentinel' 

param dataState_Enabled string = 'Enabled'

param subscription_id string = '999b83ca-672c-408d-86f7-fef298206376'


// Log Analytics Workspace -----------------------------------------------------------
resource LAW_Sentinel 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  name: logAnalyticsWorkspaceName
}


// Sentinel ---------------------------------------------------------------------------
resource Sentinel 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' existing = {
  name: logAnalyticsWorkspaceName
}  


// Data Connector - AzureSecurityCenter --------------------------------------------------------
resource DC_AzureSecurityCenter 'Microsoft.SecurityInsights/dataConnectors@2024-03-01' = {
  name:  '${logAnalyticsWorkspaceName}-AzureSecurityCenter' 
  kind: 'AzureSecurityCenter'
  scope: LAW_Sentinel
      properties: {
        dataTypes: {
          alerts: {
            state: dataState_Enabled
          }
        }
        subscriptionId: subscription_id
      }}
