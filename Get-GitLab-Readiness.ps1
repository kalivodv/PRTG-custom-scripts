param(
[string]$gitaddress
)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$response = Invoke-WebRequest -Uri $gitaddress -UseBasicParsing
$jsonresponse = ConvertFrom-Json $response.Content

if ($jsonresponse.status -eq 'ok') { $status = 0 }
else { $status = 1 }
if ($jsonresponse.master_check.status -eq 'ok') { $master_check_status = 0 }
else {

    $master_check_status = 1 
    $message += $jsonresponse.master_check.message
    
}
if ($jsonresponse.db_check.status -eq 'ok') { $db_check_status = 0 }
else {

    $db_check_status = 1 
    $message += $jsonresponse.db_check.message
    
}
if ($jsonresponse.cache_check.status -eq 'ok') { $cache_check_status = 0 }
else {

    $cache_check_status = 1 
    $message += $jsonresponse.cache_check.message
    
}
if ($jsonresponse.queues_check.status -eq 'ok') { $queues_check_status = 0 }
else {

    $queues_check_status = 1 
    $message += $jsonresponse.queues_check.message
    
}
if ($jsonresponse.shared_state_check.status -eq 'ok') { $shared_state_check_status = 0 }
else {

    $shared_state_check_status = 1 
    $message += $jsonresponse.shared_state_check.message
    
}
if ($jsonresponse.trace_chunks_check.status -eq 'ok') { $trace_chunks_check_status = 0 }
else {

    $trace_chunks_check_status = 1 
    $message += $jsonresponse.trace_chunks_check.message
    
}
if ($jsonresponse.rate_limiting_check.status -eq 'ok') { $rate_limiting_check_status = 0 }
else {

    $rate_limiting_check_status = 1 
    $message += $jsonresponse.rate_limiting_check.message
    
}
if ($jsonresponse.sessions_check.status -eq 'ok') { $sessions_check_status = 0 }
else {

    $sessions_check_status = 1 
    $message += $jsonresponse.sessions_check.message
    
}
if ($jsonresponse.gitaly_check.status -eq 'ok') { $gitaly_check_status = 0 }
else {

    $gitaly_check_status = 1 
    $message += $jsonresponse.gitaly_check.message
    
}


Write-Host "<prtg>"
Write-Host "<result>"
Write-Host "<channel>Status</channel>"
Write-Host "<value>$status</value>"
Write-Host "<ValueLookup>custom.gitlab.readiness</ValueLookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Master check</channel>"
Write-Host "<value>$master_check_status</value>"
Write-Host "<ValueLookup>custom.gitlab.readiness</ValueLookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>DB check</channel>"
Write-Host "<value>$db_check_status</value>"
Write-Host "<ValueLookup>custom.gitlab.readiness</ValueLookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Cache check</channel>"
Write-Host "<value>$cache_check_status</value>"
Write-Host "<ValueLookup>custom.gitlab.readiness</ValueLookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Queues check</channel>"
Write-Host "<value>$queues_check_status</value>"
Write-Host "<ValueLookup>custom.gitlab.readiness</ValueLookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Shared state check</channel>"
Write-Host "<value>$shared_state_check_status</value>"
Write-Host "<ValueLookup>custom.gitlab.readiness</ValueLookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Trace chunks check</channel>"
Write-Host "<value>$trace_chunks_check_status</value>"
Write-Host "<ValueLookup>custom.gitlab.readiness</ValueLookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Rate limiting check</channel>"
Write-Host "<value>$rate_limiting_check_status</value>"
Write-Host "<ValueLookup>custom.gitlab.readiness</ValueLookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Sessions check</channel>"
Write-Host "<value>$sessions_check_status</value>"
Write-Host "<ValueLookup>custom.gitlab.readiness</ValueLookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Gitaly check</channel>"
Write-Host "<value>$gitaly_check_status</value>"
Write-Host "<ValueLookup>custom.gitlab.readiness</ValueLookup>"
Write-Host "</result>"
Write-Host "<text>$message</text>"
Write-Host "</prtg>"