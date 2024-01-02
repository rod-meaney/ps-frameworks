function New-ListViewPractise {
    [CmdletBinding()]
    param ()

    #Useful for local testing
    #$FormJson = "C:\work\git\SupportTools\SupportUtilitiesPS\LMSForms\NewFirstForm.json"
    
    $FormJson =  $PSCommandPath.Replace(".ps1",".json")
    $NewForm, $FormElements = Set-FormFromJson $FormJson

    $FormElements.ListView_LV.Add_ItemSelectionChanged({
      #Event Argument: $_ = [System.Windows.Forms.ListViewItemSelectionChangedEventArgs]
      $data = New-LineDataFromListViewItem $_.Item #gives you access to known columns in csv
      if($_.IsSelected){
          Write-Host "Selected: $($_.Item.Text)" 
          foreach($col in $_.Item.ListView.Columns){
            $Column = $col.Text
            Write-Host "$Column : $($data."$Column")"
          }
      } else { 
          Write-Host "UnSelected: $($_.Item.Text)" 
      } 
      Write-Host ""
  })

    # On Load
    # Note, for the Data (CSV or SQL - use the SQL to generate a CSV to check)
    # first column matches Item element in JSON mapping
    # remaining columns (you don't need to use them all) match SubItems
        
    $Global:MyDbPath = "$(Split-Path $PSCommandPath)\MyDb.csv"
    $data = Import-Csv $MyDbPath
    Set-ListViewElementsFromData $FormElements.ListView_LV $data

    $NewForm.ShowDialog()
}
Export-ModuleMember -Function New-ListViewPractise