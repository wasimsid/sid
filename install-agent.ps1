# Load configuration from JSON
$configPath = ".\agent-config.json"
if (-Not (Test-Path $configPath)) {
    Write-Error "Configuration file not found at $configPath"
    exit 1
}

$config = Get-Content -Path $configPath | ConvertFrom-Json

# Extract variables
$agentDir   = $config.agentDir
$agentZipUrl = $config.agentZipUrl
$adoUrl     = $config.adoUrl
$adoToken   = $config.adoToken
$agentPool  = $config.agentPool
$agentName  = $config.agentName

# Step 1: Create agent directory
Write-Host "Creating agent directory at $agentDir"
New-Item -ItemType Directory -Path $agentDir -Force | Out-Null

# Step 2: Download the Azure DevOps agent ZIP
Write-Host "Downloading the Azure DevOps agent zip"
Invoke-WebRequest -Uri $agentZipUrl -OutFile "$agentDir\agent.zip"

# Step 3: Extract the agent zip
Write-Host "Extracting the Azure DevOps agent"
Expand-Archive -Path "$agentDir\agent.zip" -DestinationPath $agentDir -Force

# Step 4: Configure the Azure DevOps agent
Write-Host "Configuring the Azure DevOps agent"
Start-Process -FilePath "$agentDir\config.cmd" -ArgumentList @(
    "--unattended",
    "--url `"$adoUrl`"",
    "--auth pat",
    "--token `"$adoToken`"",
    "--pool `"$agentPool`"",
    "--agent `"$agentName`"",
    "--acceptTeeEula",
    "--runAsService"
) -Wait -NoNewWindow

# Step 5: Start the agent service
Write-Host "Starting the Azure DevOps agent as a service"
Start-Service "vstsagent.*"

Write-Host "Azure DevOps agent installation and configuration complete."
