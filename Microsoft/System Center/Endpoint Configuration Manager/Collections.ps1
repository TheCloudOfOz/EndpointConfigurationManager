$21days=New-CMSchedule -RecurInterval Days -RecurCount 21
$30days=New-CMSchedule -RecurInterval Days -RecurCount 30
New-CMDeviceCollection -LimitingCollectionName "All Systems" -Name "All Clients" -RefreshSchedule $21days -RefreshType Both
New-CMDeviceCollection -LimitingCollectionName "All Clients" -Name "RDU Clients" -RefreshSchedule $21days -RefreshType Both
New-CMDeviceCollection -LimitingCollectionName "All Systems" -Name "CM Servers" -RefreshSchedule $30days -RefreshType Periodic
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "All Clients" -QueryExpression "select * from SMS_R_System where SMS_R_System.OperatingSystemNameandVersion like 'Microsoft Windows NT Workstation %'" -RuleName "All Clients"
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "RDU Clients" -QueryExpression "select * from SMS_R_System where SMS_R_System.SystemOUName = 'MTS.COM/RDU Clients'" -RuleName "RDU Clients"
Add-CMDeviceCollectionDirectMembershipRule -CollectionName "CM Servers" -Resource (Get-CMDevice -Name "RDU-CM-01")
Add-CMDeviceCollectionDirectMembershipRule -CollectionName "CM Servers" -Resource (Get-CMDevice -Name "RDU-SVR-01")
Set-CMCollectionMembershipEvaluationComponent -SiteCode RDU -MinutesInterval 30
Get-CMDeviceCollection
Get-CMDeviceCollection | Format-Table -Property Name,CollectionId,LimitToCollectionName,MemberCount
