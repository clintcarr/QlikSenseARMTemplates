#
# QsBootstrap.ps1
#
$adminUser = $Args[0]
$adminPassword = $Args[1]
$scriptUrl = $($Args[10])
$script = $($scriptUrl)+'/cn-install.ps1'
$password =  ConvertTo-SecureString $($adminPassword) -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential -ArgumentList $env:computername\$adminUser, $password
New-Item -ItemType directory -Path C:\installation
(New-Object System.Net.WebClient).DownloadFile($($script), "c:\installation\cn-install.ps1")
Enable-PSRemoting -Force
Invoke-Command -ScriptBlock { & c:\installation\cn-install.ps1 $Args[0] $Args[1] $Args[2] $Args[3] $Args[4] $($Args[5]) $Args[6] $Args[7] $Args[8] $Args[9] } -ArgumentList ($Args[0], $Args[1], $Args[2], $Args[3], $Args[4], $($Args[5]),$Args[6], $Args[7], $Args[8], $Args[9]) -Credential $credential -ComputerName $env:COMPUTERNAME
Disable-PSRemoting -Force


