var list = [
  {
    name: 'webstorage'
    kind: 'storagev2'
    location: 'east us'
    sku_name: 'Standard_LRS'
  }
  {
    name: 'logstorage'
    kind: 'storagev2'
    location: 'west us'
    sku_name: 'Standard_LRS'
  }
]


resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = [for st in list: {
  name: st.name
  location: st.location
  kind: st.kind
  sku: {
    name: st.sku_name
  }
}]


resource storageaccount1 'Microsoft.Storage/storageAccounts@2021-02-01' = [for (st, index) in list: {
  name: '${st.name-index}'
  location: st.location
  kind: st.kind
  sku: {
    name: st.sku_name
  }
}]
 


@allowed([
  'east us'
  'west us'
])
param location string 

resource storageaccount3 'Microsoft.Storage/storageAccounts@2021-02-01' = [for (st, index) in list: if (location == st.location) {
  name: '${st.name-index}'
  location: st.location
  kind: st.kind
  sku: {
    name: st.sku_name
  }
}]
 

 