targetScope = 'subscription'

param SentinelRG string

param RGlocation string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: SentinelRG
  location: RGlocation
}


//  az deployment sub create -l <location> -f <file-name>.bicep
