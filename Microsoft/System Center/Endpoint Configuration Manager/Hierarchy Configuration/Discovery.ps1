Get-CMDiscoveryMethod
Get-CMDiscoveryMethod | Where-Object { $_.ComponentName -like "SMS_AD*" }
Get-CMDiscoveryMethod | Where-Object { $_.ComponentName -like "SMS_AD*" } | Select-Object -Property ComponentName, Flag
Get-CMDiscoveryMethod | Where-Object { $_.ComponentName -like "SMS_AD*" } | Select-Object ComponentName, @{l = "Status"; e = { switch ($_.Flag) {
            2 { Write-Output "Disabled" }
            6 { Write-Output "Enabled" }
        }
    }
}

$14days=New-CMSchedule -RecurCount 14 -RecurInterval Days
Set-CMDiscoveryMethod -ActiveDirectoryForestDiscovery -Enabled $true -EnableActiveDirectorySiteBoundaryCreation $true -PollingSchedule $14days -SiteCode RDU
(Get-CMDiscoveryMethod -Name ActiveDirectoryForestDiscovery).Properties.Props
(Get-CMDiscoveryMethod -Name ActiveDirectoryForestDiscovery).Properties.Props | Where-Object PropertyName -eq "Startup Schedule"
Convert-CMSchedule -ScheduleString "0001200000100070"
Invoke-CMForestDiscovery

Get-CMBoundary
Set-CMDiscoveryMethod -ActiveDirectorySystemDiscovery -Enabled $true -AddActiveDirectoryContainer "ldap://ou=rdu clients,dc=mts,dc=com","ldap://ou=rdu servers,dc=mts,dc=com" -SiteCode RDU -EnableDeltaDiscovery $true -DeltaDiscoveryIntervalMins 15 -PollingSchedule $14days -AddAdditionalAttribute Department
(Get-CMDiscoveryMethod -Name ActiveDirectorySystemDiscovery).EmbeddedPropertyLists."AD     Containers"
(Get-CMDiscoveryMethod -Name ActiveDirectorySystemDiscovery).Properties.Props | Where-Object PropertyName -eq "Startup Schedule"
Convert-CMSchedule -ScheduleString "000120000011E000"
(Get-CMDiscoveryMethod -Name ActiveDirectorySystemDiscovery).Properties.Props | Where-Object PropertyName -eq "Full Sync Schedule"
Convert-CMSchedule -ScheduleString "0001200000100070"
Invoke-CMSystemDiscovery -SiteCode RDU

Get-CMDevice | Select-Object -Property Name
$UserSched=New-CMSchedule -RecurCount 7 -RecurInterval Days
Set-CMDiscoveryMethod -ActiveDirectoryUserDiscovery -Enabled $true -AddActiveDirectoryContainer "ldap://ou=rdu users,dc=mts,dc=com","ldap://ou=clt users,dc=mts,dc=com" -SiteCode RDU -EnableDeltaDiscovery $true -DeltaDiscoveryMins 10 -PollingSchedule $UserSched -AddAdditionalAttribute Department,Division
(Get-CMDiscoveryMethod -Name ActiveDirectoryUserDiscovery).EmbeddedPropertyLists."AD Containers"
(Get-CMDiscoveryMethod -Name ActiveDirectoryUserDiscovery).Properties.Props | Where-Object PropertyName -eq "Startup Schedule"
(Get-CMDiscoveryMethod -Name ActiveDirectoryUserDiscovery).Properties.Props | Where-Object PropertyName -eq "Full Sync Schedule"
Convert-CMSchedule -ScheduleString "0001200000114000"
Convert-CMSchedule -ScheduleString "0001170000100038"
Invoke-CMUserDiscovery -SiteCode RDU
