# Define the URL where the JSON data is hosted
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$jsonUrl = "https://oxidized.domain.com:8888/nodes.json"

# Make an HTTP GET request to the URL and store the response in $response
$response = Invoke-RestMethod -Uri $jsonUrl

# Start generating the XML output
$xmlOutput = '<?xml version="1.0" encoding="UTF-8"?>
<prtg>
'

# Loop through each JSON object and create a channel with status converted to a numeric value
foreach ($object in $response) {
    $name = $object.name
    $status = $object.status

    # Convert status to a numeric value as per your criteria
    switch ($status) {
        "success" { $statusValue = 1 }
        "no_connection" { $statusValue = 2 }
        "never" { $statusValue = 3 }
        default { $statusValue = 4 }
    }

    # Create a channel with the name and numeric status value
    $xmlOutput += "  <result>`n"
    $xmlOutput += "    <channel>$name</channel>`n"
    $xmlOutput += "    <value>$statusValue</value>`n"
    $xmlOutput += "    <ValueLookup>custom.oxidized.status</ValueLookup>`n"
    $xmlOutput += "  </result>`n"
}

# Finish the XML output
$xmlOutput += "</prtg>"

# Output the generated XML
Write-Host $xmlOutput