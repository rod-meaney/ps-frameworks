function Set-FormElementsFromJson {
    [CmdletBinding()]
    param (
		[Parameter(Mandatory=$true)] $FormOrTab,
        [Parameter(Mandatory=$true)] $FormOrTabHash,
        [Parameter(Mandatory=$true)] $Elements
    )
    $FontSize = 9
    foreach($el in $Elements){
        $FontStyle = [System.Drawing.Font]::new("Microsoft Sans Serif", $FontSize, [System.Drawing.FontStyle]::Regular)
        if ($el.FontStyle) {
            Switch (($el.FontStyle).ToUpper()) {
                "BOLD" {$FontStyle = [System.Drawing.Font]::new("Microsoft Sans Serif", $FontSize, [System.Drawing.FontStyle]::Bold)}
                "ITALIC" {$FontStyle = [System.Drawing.Font]::new("Microsoft Sans Serif", $FontSize, [System.Drawing.FontStyle]::Italic)}
                "STRIKEOUT" {$FontStyle = [System.Drawing.Font]::new("Microsoft Sans Serif", $FontSize, [System.Drawing.FontStyle]::Strikeout)}
                "UNDERLINE" {$FontStyle = [System.Drawing.Font]::new("Microsoft Sans Serif", $FontSize, [System.Drawing.FontStyle]::Underline)}
                Default {$FontStyle = [System.Drawing.Font]::new("Microsoft Sans Serif", $FontSize, [System.Drawing.FontStyle]::Regular)}
            }
        }
        switch ($el.Type) {
            "Label" {
                $Label              = New-Object System.Windows.Forms.Label
                $Label.Text         = $el.Text
                $Label.Location     = New-Object System.Drawing.Point($el.x,$el.y)
                $Label.AutoSize     = $true
                $Label.Font         = $FontStyle
                $FormOrTabHash.Add($el.Name, $Label)
                $FormOrTab.Controls.Add($Label)
            }
            "LinkLabel" {
                #Note, you need to do Add-Click with the URL in the Form iteself
                $LinkLabel                  = New-Object System.Windows.Forms.LinkLabel
                $LinkLabel.Text             = $el.Text
                $LinkLabel.Location         = New-Object System.Drawing.Point($el.x,$el.y)
                $LinkLabel.AutoSize         = $true
                $LinkLabel.Font             = $FontStyle
                $LinkLabel.LinkColor        = "BLUE"
                $LinkLabel.ActiveLinkColor  = "RED"
                $FormOrTabHash.Add($el.Name, $LinkLabel)
                $FormOrTab.Controls.Add($LinkLabel)
            }            
            "ComboBox" {
                $ComboBox           = New-Object System.Windows.Forms.ComboBox
                $ComboBox.Width     = $el.Width
                $ComboBox.Location  = New-Object System.Drawing.Point($el.x,$el.y)
                if($el.Monospace){
                    $ComboBox.Font  = New-Object System.Drawing.Font("Courier New",$FontSize,[System.Drawing.FontStyle]::Regular)}
                else {
                    $ComboBox.Font  = $FontStyle
                } 
                #Items is optional, add lookup in ~Form.ps1
                if($el.Items) {$el.Items | ForEach-Object {[void] $ComboBox.Items.Add($_)}}
                if($el.SelectedIndex){$ComboBox.SelectedIndex = [int]$el.SelectedIndex}
                $FormOrTabHash.Add($el.Name, $ComboBox)
                $FormOrTab.Controls.Add($ComboBox)
            }
            "Button" {
                $Button             = New-Object System.Windows.Forms.Button
                $Button.Text        = $el.Text
                $Button.Location    = New-Object System.Drawing.Size($el.x,$el.y)
                $Button.Size        = New-Object System.Drawing.Size($el['Size-x'],$el['Size-y'])
                $Button.Font         = $FontStyle
                $FormOrTabHash.Add($el.Name, $Button)
                $FormOrTab.Controls.Add($Button)
            }
            "ListBox" {
                $listBox            = New-Object System.Windows.Forms.ListBox
                $listBox.Location   = New-Object System.Drawing.Point($el.x,$el.y)
                $listBox.Width      = $el.Width
                $listBox.Height     = $el.Height
                $listBox.Font       = New-Object System.Drawing.Font("Courier New",$FontSize,[System.Drawing.FontStyle]::Regular)
                if($el.Items) {$el.Items | ForEach-Object {[void] $listBox.Items.Add($_)}} 
                $FormOrTabHash.Add($el.Name, $listBox)
                $FormOrTab.Controls.Add($listBox)
                
            }
            "TextBox" {
                $textBox            = New-Object System.Windows.Forms.TextBox
                $textBox.Location   = New-Object System.Drawing.Point($el.x,$el.y)
                $textBox.Size       = New-Object System.Drawing.Size($el['Size-x'],$el['Size-y'])
                $textBox.Font       = $FontStyle 
                if($el.Multiline) {$textBox.Multiline = $el.Multiline}
                if($el.PasswordChar) {$textBox.PasswordChar = $el.PasswordChar}
                if($el.DefaultText){$textBox.Text = $el.DefaultText}
                $FormOrTabHash.Add($el.Name, $textBox)
                $FormOrTab.Controls.Add($textBox)
            }
            "CheckBox" {
                $checkBox           = New-Object System.Windows.Forms.CheckBox
                $checkBox.Location  = New-Object System.Drawing.Point($el.x,$el.y)
                $checkBox.AutoSize  = $false
                $checkBox.Text      = $el.Text
                $checkBox.Font      = $FontStyle 
                if($el.Checked) {$checkBox.Checked = $el.Checked} else {$checkBox.Checked = $false}
                $FormOrTabHash.Add($el.Name, $checkBox)
                $FormOrTab.Controls.Add($checkBox)
            }
            "Calendar" {
                $Cal                    = New-Object System.Windows.Forms.MonthCalendar
                $Cal.Location           = New-Object System.Drawing.Size($el.x,$el.y)
                $Cal.ShowTodayCircle    = $true
                $Cal.MaxSelectionCount  = 1
                $FormOrTabHash.Add($el.Name, $Cal)
                $FormOrTab.Controls.Add($Cal)
            }
            Default {
                throw "$($el.Type) is not handled by form code - check your json"
            }
        }
    }
}
Export-ModuleMember -Function Set-FormElementsFromJson