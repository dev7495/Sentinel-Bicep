module fullname_module 'sample.bicep' = {
name: 'm1'
params: {
  
  firstname: 'john'
  lastname: 'smith'
 }

}

output myname string = fullname_module.outputs.fullname

