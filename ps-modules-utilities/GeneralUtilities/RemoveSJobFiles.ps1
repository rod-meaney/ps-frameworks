function Remove-SJobFiles{
    <#
    .SYNOPSIS
        Remove files based on an array of patterns and daya old

    .DESCRIPTION
        Often called at the end of scheduled scripts based on json configirations

    .INPUTS
        No piping for the cmd-let.

    .OUTPUTS
        ????
    #>
[CmdletBinding()]
param (
    #An array of @{"pattern"="c:\Temp\ToDelete\*.*"; "days"=15}
    [Parameter(Mandatory=$true)] $FileArrayToPurge
)
    foreach($set in $FileArrayToPurge){
        Get-ChildItem $set.pattern -File | Where CreationTime -lt  (Get-Date).AddDays(-$($set.days)) | Remove-Item -Force
    }
}
Export-ModuleMember -Function Remove-SJobFiles