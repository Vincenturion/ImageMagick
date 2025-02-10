$scriptPath = $MyInvocation.MyCommand.Path
$scriptDirectory = Split-Path $scriptPath
$outputDirectory = $scriptDirectory + "\gifted"
[Int]$borderLine = 20 #1 divided by this value, e.g. 20 means 5%
$borderColor = "Red"

#Create target directory
if (-not (Test-Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

#Get all files
$files = Get-ChildItem -Path $scriptDirectory -Filter "*.gif" -Recurse -Depth 0


#Code
ForEach($file in $files) {
    $fileName = $file.FullName
    $name = Get-ChildItem -Path $fileName -Name
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
write $baseName
    $fileDirectory = $outputDirectory + "\" + $baseName

#Create file directory for split images
if (-not (Test-Path $fileDirectory)) {
    New-Item -ItemType Directory -Path $fileDirectory | Out-Null
}

    $outputName = $fileDirectory + "\" + $baseName + "_%04d" + ".png"
    magick $fileName -coalesce $outputName
}

