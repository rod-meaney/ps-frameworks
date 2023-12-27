function Get-SJobConfig{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, HelpMessage="Text to write to log")] [String]$SJobConfigFileLocation,
        [Parameter(Mandatory=$false, HelpMessage="Write Config to global log file")] [Bool]$LogConfig,
        [Parameter(Mandatory=$false, HelpMessage="If you want {Drive} to be over-written by what the config file location is")] [String]$DriveOverRide=""
    )

    $Drive = $SJobConfigFileLocation.split(":")[0]

    $configText = (Get-Content -Path $SJobConfigFileLocation -Raw).Replace("{Drive}", $Drive)
    $config = $configText | ConvertFrom-Json | ConvertTo-HashtableV5 #Powershell 6/7 has this function as a parameter on ConvertFrom-JSon
    if ($PSBoundParameters.ContainsKey('LogConfig')) {
		if ($LogConfig) {$config.Keys | sort | ForEach-Object {
				if ($($_) -like "*password*"){
					Write-Log "Config key: `"$($_)`", value:********" INFO
				} else {
					Write-Log "Config key: `"$($_)`", value:$(ConvertTo-Json $config[$_] -Compress)" INFO
				}
			}			
		}
	}

    if ($config.ContainsKey("LogLevel")){
        #Get the base config and add
        Set-LogLevel $config.LogLevel
    }

    if ($config.ContainsKey("BaseConfig")){
        #Get the base config and add
        $BaseConfigText = (Get-Content -Path $config.BaseConfig -Raw).Replace("{Drive}", $Drive)
        $BaseConfig = $BaseConfigText | ConvertFrom-Json | ConvertTo-HashtableV5
        foreach ($cfgkey in $BaseConfig.Keys | sort){
            if (-not $config.ContainsKey($cfgkey)){
                $config.Add($cfgkey, $BaseConfig[$cfgkey])
                if ($PSBoundParameters.ContainsKey('LogConfig')) {
					if ($LogConfig) {
						if ($cfgkey -like "*password*"){
							Write-Log "Config key: `"$cfgkey`", value:******** FROM BaseConfig" INFO
						} else {
							Write-Log "Config key: `"$cfgkey`", value:$(ConvertTo-Json $BaseConfig[$cfgkey] -Compress) FROM BaseConfig" INFO
						}
					}
				}
            }
        }
    }
    return $config
}

Export-ModuleMember -Function Get-SJobConfig