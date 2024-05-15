param StorageAccount string

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: StorageAccount
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

// az deployment group create -g <rg-name> -f <sa>.bicep -c
