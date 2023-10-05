#####
### Get-PRTG-MSCAUStatus.ps1
### polling Cluster Aware Updating status information; you need to use this with PSx64.exe since the ClusterAwareUpdating module only works in 64bit PS
### Usage: .\Get-PRTG-MSCAUStatus.ps1
#####

$cluster = "<Hyper-V cluster FQDN>"

Import-Module ClusterAwareUpdating

$CAUstatus = (Get-CauReport -ClusterName $cluster -Last)
$CAUlaststart = ($CAUstatus.StartTimestamp).ToString("dd.MM.yyyy hh:mm")
$CAUsucr = $CAUstatus.CountOfSucceededResults
$CAUfair = $CAUstatus.CountOfFailedResults
$CAUcanr = $CAUstatus.CountOfCanceledResults

if ($CAUstatus.Status -eq 'Succeeded') {$CAUstatusnr = 1}
elseif ($CAUstatus.Status -eq 'Failed') {$CAUstatusnr = 2}
else {$CAUstatusnr = 3}

Write-Host "<prtg>"
Write-Host "<result>"
Write-Host "<channel>Status</channel>"
Write-Host "<value>$CAUstatusnr</value>"
Write-Host "<valuelookup>custom.ms.CAU.status</valuelookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Nr. of Succeeded Results</channel>"
Write-Host "<value>$CAUsucr</value>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Nr. of Failed Results</channel>"
Write-Host "<value>$CAUfair</value>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Nr. of Canceled Results</channel>"
Write-Host "<value>$CAUcanr</value>"
Write-Host "</result>"
Write-Host "<text>Update Timestamp: $CAUlaststart</text>"
Write-Host "</prtg>"