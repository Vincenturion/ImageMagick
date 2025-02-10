$scriptPath = $MyInvocation.MyCommand.Path
$scriptDirectory = Split-Path $scriptPath
$outputDirectory = $scriptDirectory + "\togif"

#Create target directory
if (-not (Test-Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}


#Code
    $fileName = $file.FullName
    write $fileName
    $name = Get-ChildItem -Path $fileName -Name
    write $name
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    write $baseName
    
    $outputName = $outputDirectory + "\" + $baseName + ".gif"
    magick -delay 1/10 -loop 0 "$scriptDirectory\*.png" $outputName