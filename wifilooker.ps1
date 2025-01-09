$header = @"



░▒▓███████▓▒░ ░▒▓██████▓▒░▒▓████████▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░     
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░     
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░     
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░     
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░     
░▒▓███████▓▒░ ░▒▓██████▓▒░  ░▒▓█▓▒░     
                                        
                                        
                                                                                         


"@

Write-Host $header -ForegroundColor DarkGreen

Write-Host "> Finding saved password 1"
[int]$read = Read-Host "`n> Enter the number "

try{

$read -eq 1
$names = netsh wlan show profile | Select-string "All User Profile" | ForEach-Object {($_ -split ":")[1].trim()}

$count = 1


foreach($ssid in $names){

Write-Host "$count.$ssid"
$count++
}

[int]$read = Read-Host "`nEnter the number for the profile "
if($read -gt 0 -and $read -le $names.Count)
{


$checkingOffset = $names[$read - 1]


$Keyforpwd = netsh wlan show profile $checkingOffset key=clear | select-string "Key Content"


Write-Host "`n$checkingOffset : $(($Keyforpwd -replace "Key Content *:",'' ).trim())" -ForegroundColor Green

}
else
{
Write-Host "`nInvalid selection $_" -ForegroundColor DarkRed
}



}

catch{

Write-Host "Error $_"

}



