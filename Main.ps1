<#
.SYNOPSIS
    Microsoft 365 License Optimization Script
.DESCRIPTION
    Identifies inactive users and reclaims unused licenses based on last sign-in.
.NOTES
    Author: Jacques
    Version: 1.0
#>

# Requires: MS Graph PowerShell SDK
Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Identity.SignIns

# Configuration
$LogPath = ".\LicenseOptimization.log"
$ThresholdDays = 30
$TargetSkuId = "<SKU_ID>"  # Replace with actual SKU ID
$DryRun = $true            # Set to $false to apply changes

# Logging Function
function Write-Log {
    param ($Message)
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$Timestamp - $Message" | Out-File -FilePath $LogPath -Append
}

# Connect to Graph
Write-Log "Connecting to Microsoft Graph..."
Connect-MgGraph -Scopes "User.Read.All", "AuditLog.Read.All", "Directory.ReadWrite.All"

# Get licensed users
Write-Log "Fetching licensed users..."
$Users = Get-MgUser -Filter "AssignedLicenses/$count ne 0" -All

foreach ($User in $Users) {
    $SignIn = Get-MgAuditLogSignIn -Filter "UserId eq '$($User.Id)'" -Top 1 | Sort-Object CreatedDateTime -Descending
    $LastSignIn = $SignIn.CreatedDateTime
    $DaysInactive = (Get-Date) - $LastSignIn

    if ($DaysInactive.Days -ge $ThresholdDays) {
        Write-Log "User $($User.UserPrincipalName) inactive for $($DaysInactive.Days) days."

        if (-not $DryRun) {
            Write-Log "Removing license from $($User.UserPrincipalName)..."
            Set-MgUserLicense -UserId $User.Id -RemoveLicenses @($TargetSkuId) -AddLicenses @()
        }
    }
}

Write-Log "License optimization complete."
Disconnect-MgGraph