function Write-LogEnd{
    Write-Log -Text "======================= END =======================" -LogLevel EXACT
    Write-Log -Text "    Ending Script $SJobScriptName" -LogLevel EXACT
    Write-Log -Text "======================= END =======================" -LogLevel EXACT
    Write-Log -Text "" -LogLevel EXACT
}
Export-ModuleMember -Function Write-LogEnd