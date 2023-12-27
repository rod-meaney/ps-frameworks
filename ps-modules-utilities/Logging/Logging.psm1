Add-Type -TypeDefinition @"
   public enum SJobLogLevel
   {
       DEBUG=4,
       INFO=3,
       WARN=2,
       ERROR=1,
       EXACT=0,
   }
"@
#DEBUG Writes Everything
#INFO Does not write DEBUG
#WARN Does not write DEBUG, INFO
#ERROR Does not write DEBUG, INFO, WARN
#EXACT Should not be used when writing logs - it is to write to the log file without a level - i.e. the start and end of scripts


# [System.Windows.MessageBox]::Show('Add default Log for script')
$Global:SJobLogLevelStr = @{[SJobLogLevel]::DEBUG="DEBUG";[SJobLogLevel]::INFO="INFO";[SJobLogLevel]::WARN="WARN";[SJobLogLevel]::ERROR="ERROR";[SJobLogLevel]::EXACT="EXACT";}
$Global:SJobLogBase = ""
$Global:SJobLogLocation = ""
$Global:SJobScriptLevel = [SJobLogLevel]::INFO
$Global:SJobScriptName = ""
$Global:SJobScriptLocation = ""
$Global:SJobDefaultConfigFile = ""
$Global:SJobDefaultSQLFile = ""
$Global:SJobDefaultEmailTemplate = ""
$Global:SJobConfig = {}

Get-ChildItem -Path "$PSScriptRoot\*.ps1" | ForEach-Object{. $PSScriptRoot\$($_.Name)}