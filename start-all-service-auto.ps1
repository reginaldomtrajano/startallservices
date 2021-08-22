#inicia todos os serviços configurado automatico
#Reginaldo trajano
#execute como administrador

Get-WmiObject -Class Win32_Service | Where-Object {$_.State -ne "Running" -and $_.StartMode -eq "Auto"} | select-object name > C:\servicos.txt


type C:\servicos.txt
#sleep(10)


foreach($line in [System.IO.File]::ReadLines("C:\servicos.txt"))
{
  $line = $line -replace 'name', ''
  $line = $line-replace '-', ''
  $line = $line -replace '^|$',''
  $line = $line -replace '\s',''
  $line = $line -replace '\n',''
  
  if ($line) {
 
  echo "servico $line encontrado"
  Write-Output $line
  #type C:\servicos.txt
  #sleep(10)
  Start-Service -Name $line 
  Get-Service -Name $line
 
 
 } else {



 }
                
}

Get-WmiObject -Class Win32_Service | Where-Object {$_.State -eq "Running" -and $_.StartMode -eq "Auto"} | select-object name,state

Remove-Item -Force C:\servicos.txt