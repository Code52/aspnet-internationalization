#First some common params, delivered by the nuget package installer
param($installPath, $toolsPath, $package, $project)

# Grab a reference to the buildproject using a function from NuGetPowerTools
$buildProject = Get-MSBuildProject

# Add a target to your build project
$target = $buildProject.Xml.AddTarget("Psuedoizer")

# Make this target run before build
# You don't need to call your target from the beforebuild target,
# just state it using the BeforeTargets attribute
$target.BeforeTargets = "BeforeBuild"

# Add your task to the newly created target
$target.AddTask("PsuedoizerTask")

# Save the buildproject
$buildProject.Save()

# Save the project from the params
$project.Save()

Import-Module (Join-Path $toolsPath Code52.i18n.Tools.dll)

Write-Host "#############################"
Write-Host "Code52.i18n.Tools installed."
Write-Host "Comand usage:"
Write-Host "Code52-Psuedoizer -InputResourceFile -OutputResourceFile"
Write-Host "#############################"