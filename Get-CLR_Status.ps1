### Script for PRTG used for check Certificate Revocation List
## Needs CRLFreshCeck.psm1 module - it is imported as first step in the script.
## Usage: .\Get-CLR_Status.ps1 "URLtoCRLfile"
##
## Status: Fresh / Expiring / Expired
###

param([string]$url)

Import-Module "C:\Tools\PS-CRLFreshCheck\CRLFreshCheck.psm1" -Function Get-CRLFreshness

$crl = (Get-CRLFreshness -CDP $url)
$status = $crl.Status
$dwnstatus = $crl.DownloadOK
$hours = $crl.HoursTilExpiry
$days = (New-TimeSpan -Hours $hours).Days

if ($status -eq 'Fresh') { $status_nr = 1 }
elseif ($status -eq 'Expiring') { $status_nr = 2}
elseif ($status -eq 'Expired') { $status_nr = 3}
else { $status_nr = 0}

if ($dwnstatus -eq $true) { $dwnstatus_nr = 0 }
elseif ($status -eq $false) { $dwnstatus_nr = 1}

Write-Host "<prtg>"
Write-Host "<result>"
Write-Host "<channel>Status</channel>"
Write-Host "<value>$status_nr</value>"
Write-Host "<ValueLookup>custom.crl.check.status</ValueLookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>DownloadOK</channel>"
Write-Host "<value>$dwnstatus_nr</value>"
Write-Host "<ValueLookup>custom.crl.check.dwnstatus</ValueLookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Expiration</channel>"
Write-Host "<value>$days</value>"
Write-Host "<Unit>Custom</Unit>"
Write-Host "<CustomUnit>days</CustomUnit>"
Write-Host "</result>"
Write-Host "</prtg>"