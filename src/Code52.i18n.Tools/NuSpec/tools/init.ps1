#First some common params, delivered by the nuget package installer
param($installPath, $toolsPath, $package, $project)

Import-Module (Join-Path $toolsPath Code52.i18n.Tools.dll)

Write-Host "#############################"
Write-Host "Code52.i18n.Tools installed."
Write-Host "Comand usage:"
Write-Host "Code52-Psuedoizer -InputResourceFile -OutputResourceFile"
Write-Host "#############################"