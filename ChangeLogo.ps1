function ChangeLogo{
  [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
  [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

  CheckSettings
  $objLabel = New-Object System.Windows.Forms.Label
  $objLabel.Location = New-Object System.Drawing.Size(10,20)
  $objLabel.Size = New-Object System.Drawing.Size(280,20)
  $objLabel.Text = "Enter the new logo path"

  $panel1.Controls.add($objLabel)

  $objTextBox = New-Object System.Windows.Forms.TextBox
  $objTextBox.Location = New-Object System.Drawing.Size(10,40)
  $objTextBox.Size = New-Object System.Drawing.Size(260,20)
  $panel1.Controls.add($objTextBox)

  $OKButton = New-Object System.Windows.Forms.Button
  $OKButton.Location = New-Object System.Drawing.Size(75,120)
  $OKButton.Size = New-Object System.Drawing.Size(75,23)
  $OKButton.Text = "Search"
  $OKButton.Add_Click({
        ChangeImg $objTextBox.Text
      if(test-path $objTextBox.Text){
        ChangeImg $objTextBox.Text
      } else {
        showError
      }
  })

  $panel1.Controls.add($OKButton)

}

function ChangeImg($imgPath){
  Add-Type -Path dependencies\HtmlAgilityPack.dll
  $doc = New-Object HtmlAgilityPack.HtmlDocument
	$path = Get-Content .\settings.txt
  $files = Get-ChildItem $path -Filter *.html -Recurse

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
    # Get Title and Description from HTML-Files
    $htmldoc = $doc.Load($_.FullName)
    $img = $doc.DocumentNode.SelectSingleNode("//img[@class='logo']")
    if($img -eq $NULL){

    }else{
      $img.Attributes['src'] = "C:\Users\Dante\Documents\GitHub\html\buggyHeader.png"
			$doc.Save($_.FullName)
    }
  }
	showPopup "Logo changed successful"
}
