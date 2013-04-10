param($installPath, $toolsPath, $package, $project)

$buildProject = @([Microsoft.Build.Evaluation.ProjectCollection]::GlobalProjectCollection.GetLoadedProjects($project.FullName))[0]

$toEdit = $buildProject.Xml.Items | where-object { $_.Include -eq "Resources\Language.Designer.cs" }
$toEdit.AddMetaData("DependentUpon", "Resources\Language.resx")

$project.Save()

$path = [System.IO.Path]
$readmefile = $path::Combine($path::GetDirectoryName($project.FileName), "App_Readme\Code52.i18n.MVC.readme.txt")
$DTE.ItemOperations.OpenFile($readmefile)