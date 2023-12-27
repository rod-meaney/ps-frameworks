function Get-SJobConfigNodeValue{
[CmdletBinding()]
param (
    #The node you are looking for, seperated by full stops. i.e. mail.send
    [Parameter(Mandatory=$true)] [String]$node,
    #The hashtable you are serching for a value
    [Parameter(Mandatory=$true)] [hashtable]$config,
    #The value to use if it is not availbale in the config
    [Parameter(Mandatory=$true)] $default
)
    $nodes = $node.Split(".")
    $leftnode = $nodes[0]
    if ($config.ContainsKey($nodes[0])){
        if ($nodes.Count -eq 1){
            return $config[$nodes[0]]
        } else {
            $NewNode = $node.Substring($nodes[0].Length + 1, $node.Length - $nodes[0].Length - 1)
            return Get-SJobConfigNodeValue -node $NewNode -config $config[$nodes[0]] -default $default
        }
    } else {
        Return $default
    }


}
Export-ModuleMember -Function Get-SJobConfigNodeValue