# Intune Autopilot Online Registration Script

# Enable NuGet Provider
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

# Install Script
Install-Script -Name Get-WindowsAutopilotInfo -Force

# Set Execution Policy
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned

# Run online registration
Get-WindowsAutopilotInfo -Online
