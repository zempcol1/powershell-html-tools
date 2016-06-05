function ChangeFooter{
    #Load Partials
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    #Check if path is set
    CheckSettings

    $footerButton = New-Object System.Windows.Forms.Button
    $footerButton.Location = New-Object System.Drawing.Size(10,40)
    $footerButton.Size = New-Object System.Drawing.Size(200,23)
    $footerButton.Text = "Change date in footer"
    $footerButton.BackColor = "Gray"
    $footerButton.ForeColor = "White"
    $footerButton.Add_Click({
        ChangeText
    })

	$panel1.Controls.Add($footerButton)

}

function ChangeText{
    #Load Dependencies
    Add-Type -Path dependencies\HtmlAgilityPack.dll
    $doc = New-Object HtmlAgilityPack.HtmlDocument
    $path = Get-Content .\settings.txt
    $files = Get-ChildItem $path -Filter *.html -Recurse
    # All files
    $items = @()
    $result = $files | %{
        $name = $_.Fullname.Replace($path, "").Replace("\", "/")
        $sections = $name.Split("/")
        $length = $sections.Count
        $name = $sections[($length-1)]
        if($length -gt 2){
          $section = $sections[($length-2)]
        }else{
          $section = "/"
        }
        # Get Date div in footer div
        $htmldoc = $doc.Load($_.FullName)
        $footernode = $doc.DocumentNode.SelectSingleNode("//div[@class='footer']//div[@class='date']//text()")
        if($footernode.InnerText -eq $NULL){
            # Workaround: Command "Not Equal" not working
        }else{
            #Replace Text in date div
            $footernode.Text = ((get-date).Year)
            $doc.Save($_.FullName)
        }
    }
    showPopup "Footer changed successfully"
}
