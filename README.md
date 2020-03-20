# check_licence
This will check **ServiceName, ServiceType, TargetClass and ProvisioningStatus of each ServicePlan**

For this to work need to connect to office365 via powershell 

Example will be to use the 

#$UserCredential = Get-Credential#

#Connect-MsolService -Credential $UserCredential#

## Script instructions  are below

There will be a prompt to enter the if you want to start a new licence check 

Valid options will be **yes** or **y** for a fresh check

And **no** or **n** if you had initally run the script and there was a break in network or time out in the cmdlet used because of throttling from Microsoft or any other reason that make you run the script again.

Two files are generated in this script 

1. *LicenseLog.txt* "Hold logs of users with service plan"

2. *NoLicenseLog.txt* "Hold logs of users without service plan"

If entering **no** there will be a follow up prompt to enter a number where you would want to start from 

This number is gotten from the *LicenseLog.txt* file under the *serial number* column 

LOL for futher inquiries reach out to [Ogie](https://www.linkedin.com/in/ibhadogiemu-okougbo-311a5ab3)

