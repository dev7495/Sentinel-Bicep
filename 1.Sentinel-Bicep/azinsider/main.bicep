param location string = resourceGroup().location
param sentinelName string

@minValue(30)
@maxValue(730)
param retentionInDays int = 90


var workspaceName = '${location}-${sentinelName}-workspace'
var solutionName = 'SecurityInsights(${sentinelWorkspace.name})-solution'



resource sentinelWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: workspaceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: retentionInDays
  }
}

resource sentinelSolution 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: solutionName
  location: location
  properties: {
    workspaceResourceId: sentinelWorkspace.id
  }
  plan: {
    name: solutionName
    publisher: 'Microsoft'
    product: 'OMSGallery/SecurityInsights'
    promotionCode: ''
  }
}

