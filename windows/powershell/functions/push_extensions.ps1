function push_extensions {
    Remove-Item "D:\gallk\Work\Utils\shell-extensions\windows\powershell\*" -Recurse
    Copy-Item "D:\gallk\Documents\WindowsPowerShell\*" -Destination "D:\gallk\Work\Utils\shell-extensions\windows\powershell" -Recurse
}