try{
    Write-LogStart -ScriptFile $PSCommandPath -LoadConfig $true
    #Or can be written in 2 lines - delete if not using
    #Write-LogStart -ScriptFile $PSCommandPath
    #Get-SJobConfig -SJobConfigFileLocation $SJobDefaultConfigFile -LogConfig $true # $SJobDefaultConfigFile is set in Write-LogStart
    
    #Add Purge Node in config to clean up logs and any other files 
    if ((Get-SJobConfigNodeValue -node "Purge" -config $SJobConfig -default @()).length -gt 0) {
        Write-Log "Purging Files Based on config" INFO
        Remove-SJobFiles $SJobConfig.Purge
    }

    #===== Script below here =====
    write-log "Maybe this will send and email to $($SJobConfig.EmailSummaryTo)" INFO

    #===== Script above here =====
    
} catch {
    Write-log "$($_.Exception) $($_.ScriptStackTrace)" ERROR
    Exit 1
} finally {
    Write-LogEnd
}