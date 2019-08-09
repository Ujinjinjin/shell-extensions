# MAC address functions
$KamMac = "00-1E-EC-2E-DF-A2"
$Kam = "Kamil The Ujinjinjin"

$TemMac = "68-F7-28-3C-3F-60"
$Tem = "Tem The Tem"

$AlexMac = "D8-CB-8A-7F-4D-13"
$Alex = "Alexander The Great"

function Set-Mac ($Mac, $Owner) {
  Set-NetAdapter -Name "Ethernet" -MacAddress $Mac -Confirm:$false
#   Write-Host "You're using MAC of: $Owner" -ForegroundColor Magenta
  Write-Host "New MAC Address: $Mac" -ForegroundColor Cyan
}

function kam {
    Set-Mac -Mac $KamMac -Owner $Kam
}

function tem {
  Set-Mac -Mac $TemMac -Owner $Tem
}

function alex {
  Set-Mac -Mac $AlexMac -Owner $Alex
}

function mac {
    $mac = (Get-NetAdapter -Name "Ethernet").MACAddress
    
    if ($mac -eq $KamMac) {
        $macOwner = $Kam
    }
    if ($mac -eq $TemMac) {
        $macOwner = $Tem
    }
    if ($mac -eq $AlexMac) {
        $macOwner = $Alex
    }
    Write-Host "You're using MAC of: $macOwner" -ForegroundColor Magenta
}
