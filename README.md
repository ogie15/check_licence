# check_licence
This will check **ServiceName, ServiceType, TargetClass and ProvisioningStatus of each service plan**

For this to work need to connect to office365 via PowerShell 

An example will be to use the 

#$UserCredential = Get-Credential#

#Connect-MsolService -Credential $UserCredential#

## Script instructions  are below

There will be a prompt to enter the if you want to start a new licence check 

Valid options will be **yes** or **y** for a fresh check

And **no** or **n** 

If you had initially run the script and there was a break in-network or time out in the cmdlet used because of throttling from Microsoft or any other reason that makes you run the script again that is when the **no** option is needed

Two files are generated in this script 

1. *LicenseLog.txt* "Hold logs of users with service plan"

2. *NoLicenseLog.txt* "Hold logs of users without service plan"

If entering **no** there will be a follow-up prompt to enter a number where you would want to start from 

This number is gotten from the *LicenseLog.txt* file under the *serial number* column 

☺️ for further inquiries reach out to [Ogie](https://www.linkedin.com/in/ibhadogiemu-okougbo-311a5ab3)

