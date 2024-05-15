param sku_name string = 'Standard_LRS'
param allowBlobPublicAccess bool= false
param minimumTlsVersion string = 'TLS1_2'


@allowed([
  'east us'
  'west us'
])
param location string

var storage_account_prefix = 'senti1sa'

var storage_account_name = '${storage_account_prefix}${uniqueString(resourceGroup().id)}'

resource str 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storage_account_name
  location: location
  kind: 'StorageV2'
  sku: {
    name: sku_name
  }

  properties:{
    accessTier: 'Hot'
    allowBlobPublicAccess: allowBlobPublicAccess
    minimumTlsVersion: minimumTlsVersion
  }
}

//output storage_account_id string = str.id
 