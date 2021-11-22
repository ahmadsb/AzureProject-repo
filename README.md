# AzureProject-repo
to create an ARM template and script to create, upload and copy blobs from storage account to another 

main.ps1:
    is a script to run all subs scripts 
>> pwsh main.ps1
but before run main.ps1 please use same username and password in variables.ps1 file


we have three script 
first script - 
    to upload an arm templates 

to run the script you need to type 
>> pwsh ./scripts/upload_arm_templates.ps1

secound script - 
    to create, deploy and copy (100) blobs from specific storage to another and finally run it on my virtual machine
    
to run the script you need to type 
>> pwsh ./scripts/invoke_script_in_vm.ps1.ps1
