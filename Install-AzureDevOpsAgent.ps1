﻿# Define Variables
$agentDir = "C:\agent"
$agentZipUrl = "https://vstsagentpackage.azureedge.net/agent/4.254.0/vsts-agent-win-x64-4.254.0.zip"
$adoUrl = "https://dev.azure.com/AgFirstPMO" 
$adoToken = "8v98hQXSzfVyoieNT8DjG2L5PFuiLpSVSpbqX4KJ5pr5zFsegCeoJQQJ99BDACAAAAAao531AAASAZDO9nR4"   
$agentPool = "Default"                     
$agentName = "OnPremAgent-1921682739"      



# Step 1: Create agent directory
Write-Host "Creating agent directory at $agentDir"
New-Item -ItemType Directory -Path $agentDir -Force



# Step 2: Download the Azure DevOps agent ZIP
Write-Host "Downloading the Azure DevOps agent zip"
Invoke-WebRequest -Uri $agentZipUrl -OutFile "$agentDir\agent.zip"



# Step 3: Extract the agent zip
Write-Host "Extracting the Azure DevOps agent"
Expand-Archive -Path "$agentDir\agent.zip" -DestinationPath $agentDir -Force



# Step 4: Configure the Azure DevOps agent
Write-Host "Configuring the Azure DevOps agent"
& "$agentDir\config.cmd" --unattended --url $adoUrl `
    --auth pat --token $adoToken `
    --pool $agentPool --agent $agentName `
    --acceptTeeEula --runAsService



# Step 5: Start the agent as a service
Write-Host "Starting the Azure DevOps agent as a service"
Start-Process -FilePath "$agentDir\run.cmd"



Write-Host "Azure DevOps agent installation and configuration complete."