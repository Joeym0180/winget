
$repo = "microsoft/winget-cli"
$file = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle"

$releases = "https://api.github.com/repos/$repo/releases"

Write-Host "Determining latest release from $repo"
$tag = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].tag_name
write-host "Latest release is $tag"

$download = "https://github.com/$repo/releases/download/$tag/$file"

Write-Host "Dowloading $repo $tag"
Invoke-WebRequest $download -Out $file

if ((test-path -path $file -PathType leaf) -eq $true) {
    try {
        
        Import-Module Appx
        write-host "imported module Appx"
        Add-AppxPackage $file
        write-host "Added AppxPackage"
    }
    catch {
        write-warning "Could not install AppxPackage"
    }
    
} else {
    write-warning "$file not found"
}

