📦 Microsoft 365 License Optimization

Automate cost savings in Microsoft 365 by identifying inactive users and reclaiming unused licenses using PowerShell and Microsoft Graph API. Designed for integration with Power BI dashboards and enterprise workflows.

🚀 Features

Detects inactive users based on last sign-in

Removes unused licenses with dry-run safety

Modular logging and configuration

Ready for Power BI integration

Built for hybrid identity environments

📊 Use Case

This script helps IT teams:

Reduce license waste

Visualize cost trends in Power BI

Automate license reallocation

Improve audit and compliance posture

🔧 Requirements

PowerShell 7+

Microsoft Graph PowerShell SDK

Admin consent for scopes:

User.Read.All

AuditLog.Read.All

Directory.ReadWrite.All

📁 File Structure

LicenseOptimization.ps1       # Main script
LicenseOptimization.log       # Output log
README.md                     # Documentation

⚙️ Configuration

Edit the following variables in the script:

$ThresholdDays = 30           # Inactivity threshold
$TargetSkuId = "<SKU_ID>"     # License SKU to remove
$DryRun = $true               # Set to $false to apply changes

🧪 Example Output

2025-10-22 09:00:01 - Connecting to Microsoft Graph...
2025-10-22 09:00:05 - User alice@domain.com inactive for 45 days.
2025-10-22 09:00:06 - Removing license from alice@domain.com...

📈 Power BI Integration

Export logs or license data to CSV and visualize:

License assignment trends

Inactive user counts

Estimated cost savings

Reallocation impact

🛡️ Disclaimer

Use at your own risk. Always test in dry-run mode before applying changes in production.

🤝 Contributing

Pull requests welcome! Feel free to fork, improve, or adapt for your environment.
