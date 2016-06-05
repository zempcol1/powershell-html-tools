# Popup with dynamic Title and Labeltext
function ShowPopup($title){
    #Load Dependencies
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

    #Build Popup
    $objForm = New-Object System.Windows.Forms.Form
    $objForm.Text = $title
    $objForm.Size = New-Object System.Drawing.Size(300,200)
    $objForm.StartPosition = "CenterScreen"

    $objForm.KeyPreview = $True
    #Build OkButton
    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Size(75,120)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = "OK"
    $OKButton.Add_Click({
      $objForm.Close()
    })

    $objForm.Controls.Add($OKButton)
    #Build Label
    $objLabel = New-Object System.Windows.Forms.Label
    $objLabel.Location = New-Object System.Drawing.Size(10,20)
    $objLabel.Size = New-Object System.Drawing.Size(280,20)
    $objLabel.Text = $title
    $objForm.Controls.Add($objLabel)

    $objForm.Topmost = $True

    $objForm.Add_Shown({$objForm.Activate()})
    [void] $objForm.ShowDialog()
}
