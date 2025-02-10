$scriptPath = $MyInvocation.MyCommand.Path
$scriptDirectory = Split-Path $scriptPath
$outputDirectory = $scriptDirectory + "\output"
[Int]$borderLine = 20                                      #1 divided by this value, e.g. 20 means 5%
$borderColor = "Red"

#Create target directory
if (-not (Test-Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

#Get all files
$files = Get-ChildItem -Path $scriptDirectory -Include ("*.png", "*.jpeg", "*.jpg") -Exclude "bordered*" -Recurse

#Code
ForEach($file in $files) {
    $fileName = $file.FullName
    $name = Get-ChildItem -Path $fileName -Name
    $outputName = $outputDirectory + "\" + "bordered_" + $name
    [Int]$imageWidth = magick identify -format "%w" $fileName
    [Int]$imageHeight = magick identify -format "%h" $fileName
        if ($imageHeight -gt $imageWidth)
            {$imageDimension = $imageWidth}
        else
            {$imageDimension = $imageHeight}
    [Int]$borderWidth = [Int]$imageDimension / [Int]$borderLine
write-Host $name "gets a" $borderColor "border of" $borderWidth "pixels wide"
    magick $fileName -bordercolor $borderColor -border $borderWidth $outputName
}

