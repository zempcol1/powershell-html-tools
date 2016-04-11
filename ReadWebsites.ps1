# Generates and adds a list to the Panel
# Fills the list with items (1 item / HTML-File)
function readWebsites{
	# Adds HtmlAgilityPack from .NET
	Add-Type -Path C:\Temp\dependencies\HtmlAgilityPack.dll
	$doc = New-Object HtmlAgilityPack.HtmlDocument
	$path = Get-Content settings.txt

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
		$titlenode = $doc.DocumentNode.SelectSingleNode("//title")
		$descriptionnode = $doc.DocumentNode.SelectSingleNode("//meta[@name='description']")
		if ($descriptionnode) {
			$description = $descriptionnode.GetAttributeValue("content", "")
		}
		else {
			$description = ""
		}
		$title = $titlenode.InnerText
		
		#Create Item and add it to the items-array
		$item = New-Object System.Windows.Forms.ListViewItem($name)
		$item.SubItems.Add($section)
		$item.SubItems.Add($title)
		$item.SubItems.Add($description)
		
		$items += $item;
	}

	# Create a ListView, set the view to 'Details' and add columns
	$listView = New-Object System.Windows.Forms.ListView
	$listView.View = 'Details'
	$listView.Width = 650
	$listView.Height = 300

	$listView.Columns.Add('Filename', -2)
	$listView.Columns.Add('Unterordner', -2)
	$listView.Columns.Add('Titel', -1)
	$listView.Columns.Add('Beschreibung', -1)

	# Add items to the ListView
	$listView.Items.AddRange($items)
	
	# Add the ListView to the panel
	$panel1.Controls.Add($listView)
}