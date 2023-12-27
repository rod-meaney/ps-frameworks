#based on http://tramtracker.com.au/
function Get-MyLocalDBList {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)] $MyDbPath
    )
    if (-not(Test-Path $MyDbPath)){
        #Create CSV
        #$MyDbPath="C:\work\git-personal\ps-modules\Forms\MyDb.csv"
        @'
id,name,company,phone
1,Bill,Microsoft,555-1111
2,Larry,Microsoft,555-2222
3,Steve,Apple,555-3333
4,Tim,Apple,555-4444
5,Elon,Twitter,555-5555
6,jack,Twitter,555-5555
7,Jeff,Amazon,555-6666
8,Sergi,Google,555-6666
'@ | Out-File $MyDbPath -Encoding utf8
      }
      $MyDb = @{}
      Import-Csv $MyDbPath | ForEach-Object{$MyDb.Add([int]$_.id,@{"name"=$_.name;"company"=$_.company;"phone"=$_.phone})}
      Return $MyDb
}
Export-ModuleMember -Function Get-MyLocalDBList

function Save-MyLocalDBList {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)] $MyDb,
        [Parameter(Mandatory=$true)] $MyDbPath
    )
    $csv = @()
    foreach($id in $MyDb.Keys){
      $csv += [PSCustomObject]@{"id"=$id;"name"=$MyDb[$id].name;"company"=$MyDb[$id].company;"phone"=$MyDb[$id].phone}
    }
    $csv | Export-Csv $MyDbPath -NoTypeInformation -Force | OUt-Null
}
Export-ModuleMember -Function Save-MyLocalDBList
function Add-ToMyLocalDBList {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)] $Name,
        [Parameter(Mandatory=$true)] $Company,
        [Parameter(Mandatory=$true)] $Phone,
        [Parameter(Mandatory=$true)] $MyDb,
        [Parameter(Mandatory=$true)] $MyDbPath
    )
    $nextId=($Mydb.Keys | sort -Descending)[0] + 1
    $MyDb.Add($nextId,@{"name"=$Name;"company"=$Company;"phone"=$Phone})
    Save-MyLocalDBList $MyDb $MyDbPath
}
Export-ModuleMember -Function Add-ToMyLocalDBList