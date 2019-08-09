Import-Module posh-git
# Clear-Host

function prompt {
    $user = $env:UserName
    $dir = Split-Path -leaf -path (Get-Location)
    if ($dir -eq 'gallk') {
        $dir = '~'
    }

    $gitStatus = Get-GitStatus
    $branch = $gitStatus.branch

    Write-Host "$user" -NoNewLine -ForegroundColor DarkGreen
    Write-Host "@" -NoNewLine -ForegroundColor Magenta
    Write-Host "$dir" -NoNewLine -ForegroundColor DarkCyan

    if ($branch -eq "master") {
        Write-Host " ($branch*)" -NoNewLine -ForegroundColor Yellow
    }
    else {
        if ($branch.length -gt 0) {
            Write-Host " ($branch*)" -NoNewLine -ForegroundColor Cyan
        }
    }

    Write-Host ":" -NoNewLine -ForegroundColor DarkCyan
    Write-Host "$" -NoNewLine -ForegroundColor Gray
    return " "
}