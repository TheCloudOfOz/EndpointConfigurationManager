using namespace System.Management.Automation
using namespace System.Net

[ServicePointManager]::SecurityProtocol = [SecurityProtocolType]::Tls12
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned 
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

$Parameters = @{
    Confirm      = $false 
    Force        = $true
    Scope        = "CurrentUser"
    AllowClobber = $true
    Repository   = "PSGallery"
}
# Microsoft
Install-Module @Parameters -Name 'Microsoft.PowerShell.SecretManagement'
Install-Module @Parameters -Name 'Microsoft.PowerShell.SecretStore'
Install-Module @Parameters -Name 'Microsoft.Graph'
Install-Module @Parameters -Name 'POSH-SSH'
