

// Param for resource group location
param location string = resourceGroup().location


// Param for StorageAccount1 Name
@minLength(3)
@maxLength(24)
param StorageAccount string = 'sentinel1sa${uniqueString(resourceGroup().id)}'

param AppServicePlanName string


// ----------------- VARIABLE -------------------------------------------------------


// -----------------------------------------------------------------------
// Create Storage Account
resource storageAccount1 'Microsoft.Storage/storageAccounts@2023-04-01'  = {
  name: StorageAccount
  location: location 
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'

  }
}


// Create App Service Plan
resource AppServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: AppServicePlanName
  location: location

}

// Create App Service
resource AppService 'Microsoft.Web/sites@2023-12-01'  = {
  name: 'sentineltest12321'
  location: location
properties:{
  serverFarmId: AppServicePlan.id
  httpsOnly: true
}
}

