#region working
$Header1 = "UserPrincipalName," + "LicenseName," + "ServiceName," + "ServiceType," + "TargetClass," + "ProvisioningStatus,"

$Header1 | Out-File -FilePath .\LicenseLog.txt

$AllUsers = Get-MsolUser -All

$UsersUPN = $AllUsers | Select-Object UserPrincipalName

foreach ($Upn in $UsersUPN) {
    $SingleUser = $Upn.UserPrincipalName.ToString()

    $Skus = (((Get-MsolUser -UserPrincipalName $SingleUser).Licenses).AccountSku).SkuPartNumber
    
    Write-Output $SingleUser

    ForEach ($Sku in $Skus) {

        [string]$Store = " "

        $Total = @()
        
        $ServiceNames = ((((Get-MsolUser -UserPrincipalName $SingleUser).Licenses).ServiceStatus).ServicePlan).ServiceName 

        $ServiceTypes = ((((Get-MsolUser -UserPrincipalName $SingleUser).Licenses).ServiceStatus).ServicePlan).ServiceType

        $TargetClass = ((((Get-MsolUser -UserPrincipalName $SingleUser).Licenses).ServiceStatus).ServicePlan).TargetClass

        $ProvisioningStatus = (((Get-MsolUser -UserPrincipalName $SingleUser).Licenses).ServiceStatus).ProvisioningStatus

        $FinalServiceName = @()

        $FinalServiceType = @()

        $FinalTargetClass = @()

        $FinalProvisioningStatus = @()

        Foreach ($ServiceName in $ServiceNames) {

            $StoreServiceName = $ServiceName.ToString() + ","

            $FinalServiceName += $StoreServiceName
        }
        
        foreach ($ServiceType in $ServiceTypes) {

            $StoreServiceType = $ServiceType.ToString() + ","

            $FinalServiceType += $StoreServiceType

        }

        foreach ($TargetClasses in $TargetClass) {

            $StoreTargetClasses = $TargetClasses.ToString() + ","

            $FinalTargetClass += $StoreTargetClasses

        }

        foreach ($ProvisioningStat in $ProvisioningStatus) {

            $StoreProvisioningStat = $ProvisioningStat.ToString() + ","

            $FinalProvisioningStatus += $StoreProvisioningStat

        }

        $Count = $FinalServiceName.Count

        $NewCount = $Count-1

        $Looper = @(0..$NewCount)

        foreach ($Loop in $Looper) {

            if ($Loop -eq 0) {

                $Store = $SingleUser + "," + $Sku + "," + $FinalServiceName[$Loop] + $FinalServiceType[$Loop] + $FinalTargetClass[$Loop] + $FinalProvisioningStatus[$Loop]

                $Total += $Store
            }
            else {
               $Store = " "+ "," + " " + "," + $FinalServiceName[$Loop] + $FinalServiceType[$Loop] + $FinalTargetClass[$Loop] + $FinalProvisioningStatus[$Loop]

                $Total += $Store
            }
        }      
        Write-Output $Total  
        $Total | Out-File -FilePath .\LicenseLog.txt -Append
    }
}
Import-Csv .\LicenseLog.txt -delimiter ','| Export-Csv -Path .\LicenseLog.csv -NoTypeInformation
Remove-Item -Path .\LicenseLog.txt -Force
#endregion working
