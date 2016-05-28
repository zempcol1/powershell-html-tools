function CheckSettings{
  if((test-path .\settings.txt) -eq $False){
    SetSettings
  }
}
