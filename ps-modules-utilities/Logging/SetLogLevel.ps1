function Set-LogLevel{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, HelpMessage="The least log level this should write out for")] [SJobLogLevel]$LogLevelStr
    )
    switch ($LogLevelStr)
    {
        "INFO" {$global:SJobScriptLevel=[SJobLogLevel]::INFO}
        "WARN" {$global:SJobScriptLevel=[SJobLogLevel]::WARN}
        "ERROR" {$global:SJobScriptLevel=[SJobLogLevel]::ERROR}
        "DEBUG" {$global:SJobScriptLevel=[SJobLogLevel]::DEBUG}
        default {
            Throw "Invalid log level, should be one of INFO, WARN, ERROR, DEBUG" #Only EXACT will get here, all other values will be errored due to validation on SJobLogLevel
        }
    }
}
Export-ModuleMember -Function Set-LogLevel