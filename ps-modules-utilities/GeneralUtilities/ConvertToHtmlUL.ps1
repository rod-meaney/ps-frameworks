function ConvertTo-HtmlUL{
    <#
    .SYNOPSIS
        Convert String array to the HTML for a UL

    .DESCRIPTION
        Convert String array to the HTML for a UL

    .INPUTS
        No piping for the cmd-let.

    .OUTPUTS
        The HTML for a UL

    .EXAMPLE
        Example of how to run the script.

    .LINK
        n/a

    .NOTES
        n/a

    #>
[CmdletBinding()]
param (
    #Array of text items
    [Parameter(Mandatory=$true)] [String[]]$StrList
)
    Return "<ul>" + (($StrList | foreach-object{"<li>$_</li>"}) -join "") + "</ul>"
}
Export-ModuleMember -Function ConvertTo-HtmlUL