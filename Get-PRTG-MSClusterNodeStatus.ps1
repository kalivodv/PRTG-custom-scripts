#####
### Get-PRTG-MSClusterNodeStatus.ps1
### polling status information about MS Failover Cluster; you need to use this with PSx64.exe since the FailoverClusters module only works in 64bit PS
### Usage: .\Get-PRTG-MSClusterNodeStatus.ps1
#####

$cluster = "<Hyper-V cluster FQDN>"
$node = "<Hyper-V node hostname>"

Import-Module FailoverClusters

$nodestatus = (Get-ClusterNode -Cluster $cluster -Name $node)
$nodestatusinfo = $nodestatus.StatusInformation

if ($nodestatus.State -eq 'Up') {$nodestatenr = 1}
elseif ($nodestatus.State -eq 'Down') {$nodestatenr = 2}
elseif ($nodestatus.State -eq 'Paused') {$nodestatenr = 3}
elseif ($nodestatus.State -eq 'Joining') {$nodestatenr = 4}
else {$nodestatenr = 5}

if ($nodestatus.DrainStatus -eq 'NotInitiated') {$nodedrainstatusnr = 1}
elseif ($nodestatus.DrainStatus -eq 'InProgress') {$nodedrainstatusnr = 2}
elseif ($nodestatus.DrainStatus -eq 'Completed') {$nodedrainstatusnr = 3}
elseif ($nodestatus.DrainStatus -eq 'Failed') {$nodedrainstatusnr = 4}
else {$nodedrainstatusnr = 5}

Write-Host "<prtg>"
Write-Host "<result>"
Write-Host "<channel>State</channel>"
Write-Host "<value>$nodestatenr</value>"
Write-Host "<valuelookup>custom.ms.failovercluster.state</valuelookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Drain Status</channel>"
Write-Host "<value>$nodedrainstatusnr</value>"
Write-Host "<valuelookup>custom.ms.failovercluster.drainstatus</valuelookup>"
Write-Host "</result>"
Write-Host "<text>Node Status: $nodestatusinfo</text>"
Write-Host "</prtg>"