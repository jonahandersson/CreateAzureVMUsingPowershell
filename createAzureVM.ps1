#Connect to Azure Subscription account via browser using your Subscription name
Connect-AzAccount -SubscriptionName '<<Name of Azure Subscription Account>>'

#Verification of the right selection of Azure Subscription 
Set-AzContext -SubscriptionName '<<Name of Azure Subscription Account>>'

#Create a Resource Group connected to the set Aure Subscription
New-AzResourceGroup -Name "rg-azurevm-demo-powershell" -Location "NorthEU"

#Create a credential to use in the VM creation
#NOTE: Please change the username, password with security in mind 
$username = 'azurevmadmin' 
$password = ConvertTo-SecureString 'pa$$word123$%^&*' -AsPlainText -Force
$AzVMWindowsCredentials = New-Object System.Management.Automation.PSCredential ($username, $password)

#Create a Windows Virtual Machine based on desired VM Image, ex. Windows Server 2019 Datacenter 
New-AzVM `
    -ResourceGroupName 'psdemo-rg' `
    -Name 'azvmdemo-powershell-w2019dc' `
    -Image 'Win2019Datacenter' `
    -Credential $AzVMWindowsCredentials `
    -OpenPorts 3389


#Get the Public IP Address to be able to remote access it via internet using RDP
Get-AzPublicIpAddress `
    -ResourceGroupName 'rg-azurevm-demo-powershell' `
    -Name 'azvmdemo-powershell-w2019dc' | Select-Object IpAddress

#TODO: Open an RDP Client and log into it using this IP address and the credential defined above.


#Clean up after this demo
Remove-AzResourceGroup -Name 'rg-azurevm-demo-powershell'