function CheckSettings{
  #If the settings file does not exists show Popup 
  if((test-path .\settings.txt) -eq $False){
    SetSettings
  }
}
