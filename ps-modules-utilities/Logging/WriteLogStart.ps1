function Write-LogStart{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, HelpMessage="Text to write to log")] [String]$ScriptFile,
        [Parameter(Mandatory=$false, HelpMessage="Default or input paramter for Log Level")] [String]$LogLevelStr,
        [Parameter(Mandatory=$false, HelpMessage="Load config as part of this function")] [bool]$LoadConfig,
        [Parameter(Mandatory=$false, HelpMessage="Alternative Log File Name - no path")] $CustomLogFileName = ""
    )
    
    #Set globals for logging and script location
    $global:SJobScriptName = Split-Path $ScriptFile -Leaf
    $FileDir = Split-Path $ScriptFile
    $SJobLogDir = $FileDir+"\Log"
    $global:SJobScriptLocation = $FileDir
    $ScriptNameNoExtension = $SJobScriptName.Split(".")[0]
    $Global:SJobLogBase = "$SJobLogDir\$ScriptNameNoExtension"
    $global:SJobLogLocation = "$SJobLogDir\$ScriptNameNoExtension{0}.log"
    if ( $CustomLogFileName -ne "" ) {$global:SJobLogLocation = "$SJobLogDir\$CustomLogFileName{0}.log"}
    $Global:SJobDefaultConfigFile = "$FileDir\$ScriptNameNoExtension.json"
    $Global:SJobDefaultSQLFile = "$FileDir\$ScriptNameNoExtension.sql"
    $Global:SJobDefaultEmailTemplate = "$FileDir\$ScriptNameNoExtension"+"EmailTemplate.ps1"

    if (-not (Test-Path -Path $SJobLogDir)) {
        Write-Log "Creating Log directory $FileDir\Log as it does not exist" DEBUG
        New-Item -Path $FileDir -Name "Log" -ItemType Directory
    }
    
    #Standard start for every job
    Write-Log -Text "====================== START ======================" -LogLevel EXACT
    Write-Log -Text "    Starting Script for $SJobScriptName" -LogLevel EXACT
    Write-Log -Text "    In directory $FileDir" -LogLevel EXACT
    Write-Log -Text "====================== START ======================" -LogLevel EXACT

    #Set log level
    if ($PSBoundParameters.ContainsKey('LogLevelStr')) {Set-LogLevel $LogLevelStr}
    
    #Load Config
    if ($PSBoundParameters.ContainsKey('LoadConfig')) {if ($LoadConfig) {$Global:SJobConfig = Get-SJobConfig -SJobConfigFileLocation $SJobDefaultConfigFile -LogConfig $true}}

}
Export-ModuleMember -Function Write-LogStart