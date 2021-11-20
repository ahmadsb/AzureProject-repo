
# import the config env file
. ./Variables.ps1


# ======== AUX Functions =======
# Funtion to create or update resource group and deploy an ARM templates to Azure Cloud
function Update-ResourceGroup {
  param ([string[]]$templates)

  foreach ($template in $templates) {
    New-AzResourceGroupDeployment `
      -Name VMStorageTemplate `
      -ResourceGroupName "myResourceGroup" `
      -TemplateFile $template
  }
}

#  ======= my code ========
# connection with subscription to Azure cloud
Set-AzContext -Subscription $SubscriptionID

# create resource group 
New-AzResourceGroup `
  -Name "myResourceGroup" `
  -Location $ResourceGroupLocation
# add an ARM templates to resource group 
Update-ResourceGroup $templates