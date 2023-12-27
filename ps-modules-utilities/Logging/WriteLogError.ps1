function Write-LogError{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, HelpMessage="Exception caught in error")] $Exception,
        [Parameter(Mandatory=$true, HelpMessage="InvocationInfo from caller")] $InvocationInfo
    )
    Write-Log "$($Exception.Message)" ERROR
    Write-Log "Invocation information" ERROR
    $props = @("ScriptLineNumber", "Line", "ScriptName", "MyCommand", "InvocationName")
    foreach ($prop in $props){
        Write-Log "$prop : $($InvocationInfo.$prop)" ERROR
    }
}
Export-ModuleMember -Function Write-LogError

