@minLength(3)
@maxLength(24)
param name string

param sku_name string = 'Standard_LRS'

param allowBlobPublicAccess bool = false


@description('specify minimum TLS version')
@allowed([
  'TLS1_1'
  'TLS1_2'
])
param minimumTlsVersion string


@allowed([
  'east us'
  'west us'
])
param location string

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: name
  location: location
  kind: 'StorageV2'
  sku: {
    name: sku_name
  }
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: allowBlobPublicAccess
    minimumTlsVersion: minimumTlsVersion
  }
}
