Get-ChildItem -Path "$PSScriptRoot\*.ps1" | ForEach-Object{. $PSScriptRoot\$($_.Name)}