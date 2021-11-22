. ./../Variables.ps1
#run script in my virtual machine 
Invoke-AzVMRunCommand -ResourceGroupName $MyResourceGroup -Name $VMName -CommandId 'RunPowerShellScript' -ScriptPath './scripts/copy_blobs.ps1' -Parameter @{$param1 =$val1;$param2 = $val2}

     