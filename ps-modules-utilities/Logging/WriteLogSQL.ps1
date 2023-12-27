function Write-LogSQL{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, HelpMessage="Part of file name to write out to")] $SQLLabel,
        [Parameter(Mandatory=$true, HelpMessage="SQL to write out")] [String]$SQL
    )
    $SQL | Out-File ($SJobLogBase + $SQLLabel + ".sql")
}
Export-ModuleMember -Function Write-LogSQL