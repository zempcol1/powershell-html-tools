function ChangeFooter{
	Add-Type -Path dependencies\HtmlAgilityPack.dll
  $doc = New-Object HtmlAgilityPack.HtmlDocument
	CheckSettings
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
    $footernode = $doc.DocumentNode.SelectSingleNode("//div[class='footer']")
    if($footernode.InnerText -eq $NULL){

    }else{
      $footernode
      $footernode.InnerText.Replace((get-date).Year)
    }
  }

}
