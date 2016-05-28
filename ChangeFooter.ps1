function ChangeFooter{
  [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
  [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

	CheckSettings

	$OKButton = New-Object System.Windows.Forms.Button
  $OKButton.Location = New-Object System.Drawing.Size(0,0)
  $OKButton.Size = New-Object System.Drawing.Size(200,23)
  $OKButton.Text = "Change date in footer"
  $OKButton.Add_Click({
    	ChangeText
  })

	$panel1.Controls.Add($OKButton)

}

function ChangeText{
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
    $footernode = $doc.DocumentNode.SelectSingleNode("//div[@class='footer']//div[@class='date']//text()")
    if($footernode.InnerText -eq $NULL){

    }else{
      $footernode.Text = ((get-date).Year)
			$doc.Save($_.FullName)
    }
  }
	showPopup "Footer changed successful"
}
