$Value = Read-Host -Prompt "Do you want to start a License Check ?"



if ($Value -eq "yes" -or $Value -eq "y" ){

    $Answer = $false

    $Header1 = "Serial Number," + "UserPrincipalName," + "ServiceName," + "ServiceType," + "TargetClass," + "ProvisioningStatus,"

    $Header2 = "Serial Number," + "UserPrincipalName," 

    $Header1 | Out-File -FilePath .\LicenseLog.txt

    $Header2 | Out-File -FilePath .\NoLicenseLog.txt



}elseif($Value -eq "no" -or $Value -eq "n"){

    $Answer = $true

    $FirstNumber = Read-Host -Prompt "Enter Number You want to Start From ? "

}else{

    $Answer = "InValid"

}



# If new 

if($Answer -eq $false){

    $AllUsers = Get-MsolUser -All



    $UsersUPN = $AllUsers | Select-Object UserPrincipalName



    $UserCount = $AllUsers.Count



    $FirstNumber = 0



    $LastNumber = $UserCount - 1



    $UserLooper = @($FirstNumber..$LastNumber)





    foreach($User in $UserLooper){



        $UpnValue = $UsersUPN[$User].UserPrincipalName



        $ServiceCheck = ((Get-MsolUser -UserPrincipalName $UpnValue).Licenses).ServiceStatus

    

        if($null -eq $ServiceCheck){



            # Write-Output ((Get-MsolUser -UserPrincipalName $UpnValue).Licenses).ServiceStatus

            $User.ToString() + "," + $UpnValue + "," + "`n" | Out-File -FilePath .\NoLicenseLog.txt -Append

            Write-Output $UpnValue " Has No License refer to NolicenseLog" "`r`n"

        

        }else{

            $ServiceName = ((((Get-MsolUser -UserPrincipalName $UpnValue).Licenses).ServiceStatus).ServicePlan).ServiceName 

            $ServiceType = ((((Get-MsolUser -UserPrincipalName $UpnValue).Licenses).ServiceStatus).ServicePlan).ServiceType

            $TargetClass = ((((Get-MsolUser -UserPrincipalName $UpnValue).Licenses).ServiceStatus).ServicePlan).TargetClass

            $ProvisioningStatus = (((Get-MsolUser -UserPrincipalName $UpnValue).Licenses).ServiceStatus).ProvisioningStatus

            $FinalServiceName = @()

            $FinalServiceType = @()

            $FinalTargetClass = @()

            $FinalProvisioningStatus = @()

            $Store = ""

            $Total = @()



            foreach($Service in $ServiceName){

                $Store = $Service.ToString() + ","

                $FinalServiceName += $Store

            }



            foreach($Service in $ServiceType){

                $Store = $Service.ToString() + ","

                $FinalServiceType += $Store

            }



            foreach($Service in $TargetClass){

                $Store = $Service.ToString() + ","

                $FinalTargetClass += $Store

            }



            foreach($Service in $ProvisioningStatus){

                $Store = $Service.ToString() + ","

                $FinalProvisioningStatus += $Store

            }



            $Count = $FinalServiceName.Count

            $Looper = @(0..$Count)

            foreach($Loop in $Looper){

                if($Loop -eq 0){

                    

                    $Store = $User.ToString() + "," + $UpnValue + "," + $FinalServiceName[$Loop] + $FinalServiceType[$Loop] + $FinalTargetClass[$Loop] + $FinalProvisioningStatus[$Loop]

                    $Total += $Store

                }else{

                    $Store = " " + "," + " " + "," + $FinalServiceName[$Loop] + $FinalServiceType[$Loop] + $FinalTargetClass[$Loop] + $FinalProvisioningStatus[$Loop]

                    $Total += $Store

                }

            }

            $Total | Out-File -FilePath .\LicenseLog.txt -Append

            Write-Output $UpnValue " Has License refer to LicenseLog" "`r`n"

        }

    }

# If Old

}elseif($Answer -eq $true){

    $AllUsers = Get-MsolUser -All



    $UsersUPN = $AllUsers | Select-Object UserPrincipalName



    $UserCount = $AllUsers.Count



    $LastNumber = $UserCount - 1



    $UserLooper = @($FirstNumber..$LastNumber)





    foreach($User in $UserLooper){



        $UpnValue = $UsersUPN[$User].UserPrincipalName



        $ServiceCheck = ((Get-MsolUser -UserPrincipalName $UpnValue).Licenses).ServiceStatus

    

        if($null -eq $ServiceCheck){



            # Write-Output ((Get-MsolUser -UserPrincipalName $UpnValue).Licenses).ServiceStatus

            $User.ToString() + "," + $UpnValue + "," + "`n" | Out-File -FilePath .\NoLicenseLog.txt -Append

            Write-Output $UpnValue " Has No License refer to NolicenseLog" "`r`n"

        

        }else{

            $ServiceName = ((((Get-MsolUser -UserPrincipalName $UpnValue).Licenses).ServiceStatus).ServicePlan).ServiceName 

            $ServiceType = ((((Get-MsolUser -UserPrincipalName $UpnValue).Licenses).ServiceStatus).ServicePlan).ServiceType

            $TargetClass = ((((Get-MsolUser -UserPrincipalName $UpnValue).Licenses).ServiceStatus).ServicePlan).TargetClass

            $ProvisioningStatus = (((Get-MsolUser -UserPrincipalName $UpnValue).Licenses).ServiceStatus).ProvisioningStatus

            $FinalServiceName = @()

            $FinalServiceType = @()

            $FinalTargetClass = @()

            $FinalProvisioningStatus = @()

            $Store = ""

            $Total = @()



            foreach($Service in $ServiceName){

                $Store = $Service.ToString() + ","

                $FinalServiceName += $Store

            }



            foreach($Service in $ServiceType){

                $Store = $Service.ToString() + ","

                $FinalServiceType += $Store

            }



            foreach($Service in $TargetClass){

                $Store = $Service.ToString() + ","

                $FinalTargetClass += $Store

            }



            foreach($Service in $ProvisioningStatus){

                $Store = $Service.ToString() + ","

                $FinalProvisioningStatus += $Store

            }



            $Count = $FinalServiceName.Count

            $Looper = @(0..$Count)

            foreach($Loop in $Looper){

                if($Loop -eq 0){

                    

                    $Store = $User.ToString() + "," + $UpnValue + "," + $FinalServiceName[$Loop] + $FinalServiceType[$Loop] + $FinalTargetClass[$Loop] + $FinalProvisioningStatus[$Loop]

                    $Total += $Store

                }else{

                    $Store = " " + "," + " " + "," + $FinalServiceName[$Loop] + $FinalServiceType[$Loop] + $FinalTargetClass[$Loop] + $FinalProvisioningStatus[$Loop]

                    $Total += $Store

                }

            }

            $Total | Out-File -FilePath .\LicenseLog.txt -Append

            Write-Output $UpnValue " Has License refer to LicenseLog" "`r`n"

        }

    }

}elseif ($Answer -eq "InValid") {

    Write-Output "Please Enter a Valid Response"

}