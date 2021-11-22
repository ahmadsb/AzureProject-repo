$SubscriptionID = "a8108c2b-496c-424d-8347-ecc8afb6384c"
$ResourceGroupLocation = "Central US"
[string[]]$templates = "./armTemplates/StorageAccount.json", "./armTemplates/WinVM.json" 
$MyResourceGroup = "myResourceGroup"

#  connect to my VM
$VMName = "simple-vm"
$param1 = "adminUsername"
$param2 = "adminPassword"
$val1 = "ahmad"
$val2 = "audi_%10018T99"
