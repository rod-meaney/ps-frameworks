function Write-Log{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, HelpMessage="Text to write to log")] $Text,
        [Parameter(Mandatory=$true, HelpMessage="The least log level this should write out for")] [SJobLogLevel]$LogLevel
    )

    #Write-host "SJob Log Loc: $SJobLogLocation"

    $Date = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    if ($LogLevel -eq [SJobLogLevel]::EXACT) {
        Add-Content -Path ($SJobLogLocation -f (Get-Date).ToString("yyyy-MM-dd")) -Value "$date $Text"
		Write-Host "$date $Text"
    } else {
        if ($LogLevel -le $SJobScriptLevel){
            Add-Content -Path ($SJobLogLocation -f (Get-Date).ToString("yyyy-MM-dd")) -Value "$date $LogLevel $Text"
			Write-Host "$date $LogLevel $Text"
        }
    }
}
Export-ModuleMember -Function Write-Log