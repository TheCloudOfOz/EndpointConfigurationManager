# EndpointConfigurationManager
Microsoft Endpoint Configuration Manager PowerShell Repository

## Repository

### Microsoft

1. System Center \ **Endpoint Configuration Manager**
2. System Center \ Operation Manager
3. System Center \ Virtual Machine Manager
4. System Center \ Data Protection Manager
5. System Center \ Service Manager



## Install.ps1

```powershell
using namespace System.Management.Automation
using namespace System.Net

[ServicePointManager]::SecurityProtocol = [SecurityProtocolType]::Tls12
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned 
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
```

This PowerShell code snippet performs a series of tasks related to PowerShell execution and configuration:

1. `using namespace` statements are used to specify namespaces that you want to use in your PowerShell script.

   - `System.Management.Automation`: This namespace is used for managing and interacting with PowerShell itself.

   - `System.Net`: This namespace is used for network-related functionality.

2. `[ServicePointManager]::SecurityProtocol = [SecurityProtocolType]::Tls12`: This line configures the security protocol used for web requests. It sets the security protocol to TLS 1.2, which is a secure version of the Transport Layer Security (TLS) protocol used for secure communication over the internet. This is commonly used to ensure secure web requests when interacting with remote services.

3. `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`: This line sets the execution policy for PowerShell scripts to "RemoteSigned." The execution policy determines the level of security for running PowerShell scripts. "RemoteSigned" means that locally created scripts can be run without any digital signature, but scripts downloaded from the internet must be digitally signed by a trusted publisher to be executed.

4. `Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted`: This line configures the PowerShell repository named 'PSGallery.' It sets the installation policy for this repository to "Trusted." The PSGallery is the default repository for PowerShell modules and scripts. Setting the installation policy to "Trusted" means that you trust the sources from PSGallery and are willing to install modules and scripts from there without further prompts or restrictions.

In summary, this code sets up the appropriate security protocols for web requests, adjusts the execution policy to allow the execution of scripts downloaded from the internet (but they must be signed), and configures the PSGallery repository to allow the installation of modules and scripts from it without additional prompts.

```powershell
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
```

This PowerShell code snippet is used to install several modules from the PowerShell Gallery. Let me break it down step by step:

1. `$Parameters` is a hashtable (dictionary) in PowerShell that is used to store a set of parameters for later use.

   - `Confirm`: This parameter is set to `$false`, which means that the cmdlets (commands) that use this parameter will not prompt the user for confirmation when performing actions.

   - `Force`: This parameter is set to `$true`, which forces the installation of modules without asking for user confirmation. It will overwrite existing modules if necessary.

   - `Scope`: This parameter is set to `"CurrentUser"`, which specifies that the modules should be installed for the current user only, as opposed to all users on the system.

   - `AllowClobber`: This parameter is set to `$true`, allowing the installation of modules even if they have the same name as existing modules.

   - `Repository`: This parameter is set to `"PSGallery"`, indicating that the modules should be downloaded from the PowerShell Gallery repository.

2. The code then proceeds to install several PowerShell modules using the `Install-Module` cmdlet. It passes the parameters defined in `$Parameters` to each installation:

   - `'Microsoft.PowerShell.SecretManagement'`: This installs the Microsoft.PowerShell.SecretManagement module, which is used for managing secrets in PowerShell.

   - `'Microsoft.PowerShell.SecretStore'`: This installs the Microsoft.PowerShell.SecretStore module, which is a store provider for the SecretManagement module. It provides a secure storage mechanism for secrets.

   - `'Microsoft.Graph'`: This installs the Microsoft.Graph module, which is used for interacting with Microsoft Graph API services.

   - `'POSH-SSH'`: This installs the POSH-SSH module, which provides cmdlets for SSH-related operations in PowerShell.

Overall, this code sets up a set of parameters for module installation and then uses these parameters to install specific PowerShell modules from the PowerShell Gallery repository, ensuring that the installation is forced and doesn't prompt for confirmation.

