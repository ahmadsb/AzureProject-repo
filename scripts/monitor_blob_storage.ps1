# import the config env file
. ./../Variables.ps1




#  ======= my code ========
# connection with subscription to Azure cloud
Set-AzContext -Subscription $SubscriptionID

$storageA_account_resource_id = "/subscriptions/a8108c2b-496c-424d-8347-ecc8afb6384c/resourceGroups/myResourceGroup/providers/Microsoft.Storage/storageAccounts/0storagehkiuxs6hjx22o"
$storageA_service_resource_id = "/subscriptions/a8108c2b-496c-424d-8347-ecc8afb6384c/resourceGroups/myResourceGroup/providers/Microsoft.Storage/storageAccounts/0storagehkiuxs6hjx22o/blobServices/default"

$storageB_account_resource_id = "/subscriptions/a8108c2b-496c-424d-8347-ecc8afb6384c/resourceGroups/myResourceGroup/providers/Microsoft.Storage/storageAccounts/1storagehkiuxs6hjx22o"
$storageB_service_resource_id = "/subscriptions/a8108c2b-496c-424d-8347-ecc8afb6384c/resourceGroups/myResourceGroup/providers/Microsoft.Storage/storageAccounts/1storagehkiuxs6hjx22o/blobServices/default"

# Archive logs to a storage account
Set-AzDiagnosticSetting -ResourceId $storageA_service_resource_id -StorageAccountId $storageA_account_resource_id -Enabled $true -Category StorageWrite,StorageRead,StorageDelete
Set-AzDiagnosticSetting -ResourceId $storageB_service_resource_id -StorageAccountId $storageB_account_resource_id -Enabled $true -Category StorageWrite,StorageRead,StorageDelete


#  create dashboard 

# Dashboard Title
$dashboardTitle = 'Simple VM Dashboard'

# Dashboard Name
$dashboardName = $dashboardTitle -replace '\s'

# # Your Azure Subscription ID
# $subscriptionID = (Get-AzContext).Subscription.Id




$myPortalDashboardTemplateUrl = 'https://raw.githubusercontent.com/Azure/azure-docs-powershell-samples/master/azure-portal/portal-dashboard-template-testvm.json'

$myPortalDashboardTemplatePath = "./../armTemplates/Dashboard.json"

Invoke-WebRequest -Uri $myPortalDashboardTemplateUrl -OutFile $myPortalDashboardTemplatePath -UseBasicParsing

# Customize the template
$Content = Get-Content -Path $myPortalDashboardTemplatePath -Raw
$Content = $Content -replace '<subscriptionID>', $SubscriptionID
# $Content = $Content -replace '<rgName>', $resourceGroupName
$Content = $Content -replace '<vmName>', $VMName
$Content = $Content -replace '<dashboardTitle>', $dashboardTitle
$Content = $Content -replace '<location>', $ResourceGroupLocation
$Content | Out-File -FilePath $myPortalDashboardTemplatePath -Force

Write-Host $resourceGroupName
# Deploy the dashboard template
$DashboardParams = @{
    DashboardPath = $myPortalDashboardTemplatePath
    resourceGroupName = $MyResourceGroup
    DashboardName = $dashboardName
  }
New-AzPortalDashboard @DashboardParams

# Review the deployed resources
# Check that the dashboard was created successfully.
Get-AzPortalDashboard -Name $dashboardName -resourceGroupName $MyResourceGroup



