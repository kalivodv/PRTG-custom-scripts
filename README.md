# PRTG-custom-scripts
Collection of my custom scripts for PRTG EXE/XML advanced sensor

## Get-AD-KRBTGT-Expiration
Password of Krbtgt user accounts in AD should be periodically reset. This script hels you monitor when the password was last set.

## Get-CLR_Status
This sensor checks freshness of certificate revocation lists on your CA. It uses PS module CRLFreshCeck: https://learn.microsoft.com/en-us/archive/blogs/russellt/get-crlfreshness

## Get-GitLab-Readiness
This sensor checks the health of your on-prem GitLab instance. Use with param: -gitaddress "https://git.domain.com/-/readiness?token=XXX&all=1"

## Get-PRTG-MSCAUStatus
If you use Cluster Aware Updating on your Hyper-V cluster, this sensor helps you check health of this service. You need to use this with PSx64.exe since the ClusterAwareUpdating module only works in 64bit PS.

## Get-PRTG-MSClusterNodeStatus
Check health of your Hyper-V cluster nodes. You need to use this with PSx64.exe since the FailoverClusters module only works in 64bit PS.

## Get-PRTG-Oxidized-Status
Oxidized is great tool for network devices config backup. With this sensor you can check if the configs are pulled successfuly.