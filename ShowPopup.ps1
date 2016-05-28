function ShowPopup($title){
  [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
  [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

  $objForm = New-Object System.Windows.Forms.Form
  $objForm.Text = $title
  $objForm.Size = New-Object System.Drawing.Size(300,200)
  $objForm.StartPosition = "CenterScreen"

  $objForm.KeyPreview = $True

  $OKButton = New-Object System.Windows.Forms.Button
  $OKButton.Location = New-Object System.Drawing.Size(75,120)
  $OKButton.Size = New-Object System.Drawing.Size(75,23)
  $OKButton.Text = "OK"
  $OKButton.Add_Click({
      $objForm.Close()
  })

  $objForm.Controls.Add($OKButton)

  $objLabel = New-Object System.Windows.Forms.Label
  $objLabel.Location = New-Object System.Drawing.Size(10,20)
  $objLabel.Size = New-Object System.Drawing.Size(280,20)
  $objLabel.Text = $title
  $objForm.Controls.Add($objLabel)

  $objForm.Topmost = $True

  $objForm.Add_Shown({$objForm.Activate()})
  [void] $objForm.ShowDialog()
}
