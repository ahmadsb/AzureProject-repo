# to prepare the templates 
pwsh ./scripts/upload_arm_templates.ps1
#create deploy and copy blobs from storage account to another
pwsh ./scripts/copy_blobs.ps1
#run invoke the script to my vm that I created above
pwsh ./scripts/invoke_script_in_vm.ps1


