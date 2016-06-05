function SetSettings{
    #Load Dependencies
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

    #Build Popup
    $objForm = New-Object System.Windows.Forms.Form
    $objForm.Text = "Set Folder Path"
    $objForm.Size = New-Object System.Drawing.Size(300,200)
    $objForm.StartPosition = "CenterScreen"

    $objForm.KeyPreview = $True
    $objForm.Add_KeyDown({if ($_.KeyCode -eq "Enter")
      {
        # Save Text to file if is valid path
        if(test-path $objTextBox.Text){
            $objTextBox.Text | out-file .\settings.txt
            $objForm.Close()
        } else {
          showError
        }
    }})
    $objForm.Add_KeyDown({if ($_.KeyCode -eq "Escape")
      {$objForm.Close()}})
    #Build OkButton
    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Size(75,120)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = "OK"
    $OKButton.Add_Click({
    # Save Text to file if is valid path
    if(test-path $objTextBox.Text){
      $objTextBox.Text | out-file .\settings.txt
      $objForm.Close()
    } else {
        # Show Error if not valid
        showError
    }
    })
    $objForm.Controls.Add($OKButton)

    #Build Cancel Button
    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Size(150,120)
    $CancelButton.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton.Text = "Cancel"
    $CancelButton.Add_Click({$objForm.Close()})
    $objForm.Controls.Add($CancelButton)

    #Build Label
    $objLabel = New-Object System.Windows.Forms.Label
    $objLabel.Location = New-Object System.Drawing.Size(10,20)
    $objLabel.Size = New-Object System.Drawing.Size(280,20)
    $objLabel.Text = "Enter the folder path"
    $objForm.Controls.Add($objLabel)

    $objTextBox = New-Object System.Windows.Forms.TextBox
    $objTextBox.Location = New-Object System.Drawing.Size(10,40)
    $objTextBox.Size = New-Object System.Drawing.Size(260,20)
    $objForm.Controls.Add($objTextBox)

    $objForm.Topmost = $True

    $objForm.Add_Shown({$objForm.Activate()})
    [void] $objForm.ShowDialog()
    }
function showError{
    #Load Dependencies
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    #Build Popup
    $objForm = New-Object System.Windows.Forms.Form
    $objForm.Text = "Invalid path"
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
    $objLabel.Text = "Invalid path"
    $objForm.Controls.Add($objLabel)

    $objForm.Topmost = $True

    $objForm.Add_Shown({$objForm.Activate()})
    [void] $objForm.ShowDialog()
}
