

. ./../Variables.ps1
# ======= AUX Functions ============
function Update-BlobsToContainers {
    param ([string]$containerName, $ctx, [int]$num)
    $i = 1
    DO {
        $nameFile = "file" + $i.ToString() + ".txt" 

        Set-AzStorageBlobContent -File "./file.txt" `
            -Container $containerName `
            -Blob $nameFile `
            -Context $ctx
        $i++
    }while ($i -le $num)
    
}

function Copy-BlobsToStorageAccount {
    param ($srcContext, $srcContainer, $destContext, $destContainer, [int]$num)
    $i = 1
    DO {
        $nameFile = "file" + $i.ToString() + ".txt" 

        Start-AzStorageBlobCopy -SrcBlob $nameFile `
            -SrcContainer $srcContainer `
            -Context $srcContext `
            -DestBlob $nameFile `
            -DestContainer $destContainer `
            -DestContext $destContext
        $i++
    }while ($i -le $num)
    
}
# ===================================== my code =============================================
# we assuming that we have an arm teamplates for virtual machine and storage account with two accounts
#connect to azure cloud using subscription
Set-AzContext -Subscription $SubscriptionID


#  Source Storage Account
$srcResourceGroupName = $MyResourceGroup
$storages = Get-AzStorageAccount -ResourceGroupName $srcResourceGroupName
$srcStorageAccountName = $storages.StorageAccountName[0]
$srcContainer = "sourcefolder"
$storageAccountSrc = Get-AzStorageAccount -ResourceGroupName $srcResourceGroupName -Name $srcStorageAccountName
$srcContext = $storageAccountSrc.Context

#  Destination Storage Account
$destResourceGroupName = $MyResourceGroup
$destStorageAccountName = $storages.StorageAccountName[1]
$destContainer = "destinationfolder"
$storageAccountDest = Get-AzStorageAccount -ResourceGroupName $destResourceGroupName -Name $destStorageAccountName
$destContext = $storageAccountDest.Context


# Create container in Storage account (Source)
New-AzStorageContainer -Name $srcContainer -Context $srcContext -Permission blob
# Create container in Storage account (Dest)
New-AzStorageContainer -Name $destContainer -Context $destContext -Permission blob


#number the files do you want to create, upload and copy
$number = 100
# Upload (100) empty files blobs to the container in storage account A
Update-BlobsToContainers $srcContainer $srcContext $number
#copy (100) blobs to another storage
Copy-BlobsToStorageAccount $srcContext $srcContainer  $destContext $destContainer $number

               