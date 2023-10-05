Import-Module ActiveDirectory

$today = (Get-Date)
$krbtgtUsers = (Get-ADUser -Filter {name -like "krbtgt*"} -Properties name,passwordlastset)

Write-Host "<prtg>"

foreach($one in $krbtgtUsers){

    $username = $one.Name
    $psswdlastset = $one.PasswordLastSet
    $days = (New-TimeSpan -Start $psswdlastset -End $today).Days

    Write-Host "<result>"
    Write-Host "<channel>$username</channel>"
    Write-Host "<value>$days</value>"
    Write-Host "<Unit>Custom</Unit>"
    Write-Host "<CustomUnit>days</CustomUnit>"
    Write-Host "<LimitMaxWarning>166</LimitMaxWarning>"
    Write-Host "<LimitMaxError>173</LimitMaxError>"
    Write-Host "<LimitMinError>2</LimitMinError>"
    Write-Host "</result>"    

}


Write-Host "</prtg>"