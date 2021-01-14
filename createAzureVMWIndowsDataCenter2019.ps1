#Connect to Azure Subscription account via browser using your Subscription name
Connect-AzAccount -SubscriptionName '<<Name of Azure Subscription Account>>'

#Verification of the right selection of Azure Subscription 
Set-AzContext -SubscriptionName '<<Name of Azure Subscription Account>>'

#Create a Resource Group connected to the set Aure Subscription
New-AzResourceGroup -Name "rg-azurevm-demo-powershell" -Location "NorthEU" 

#Create a credential to use in the VM creation
#NOTE: Please change the username, password with security in mind
#RECOMMENDED to use Azure Key Vault! 
$username = '<Your Desired VM admin Name here>' 
$password = ConvertTo-SecureString '<Your Secure Password Here>' -AsPlainText -Force
$AzVMWindowsCredentials = New-Object System.Management.Automation.PSCredential ($username, $password)

#Create a Windows Virtual Machine based on desired VM Image, ex. Windows Server 2019 Datacenter 
New-AzVM 
    -ResourceGroupName '<Your Resource Group Name here>' #example rg-azurevm-demo-powershell
    -Name 'azvmdemo-powershell-w2019dc' 
    -Image 'Win2019Datacenter' 
    -Credential $AzVMWindowsCredentials 
    -OpenPorts 3389


#Get the Public IP Address to be able to remote access it via internet using RDP
Get-AzPublicIpAddress 
    -ResourceGroupName '<Your Resource Group Name here>' #example rg-azurevm-demo-powershell
    -Name 'azvmdemo-powershell-w2019dc' | Select-Object IpAddress

#TODO: Remotely access new Azure VM using Remote Desktop via RDP Client from your computer
#NOTE Login using Public IP address and the admin user credentials 


#Clean up after this demo
Remove-AzResourceGroup -Name 'rg-azurevm-demo-powershell'
