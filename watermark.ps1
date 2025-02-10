$scriptPath = $MyInvocation.MyCommand.Path
$scriptDirectory = Split-Path $scriptPath
$outputDirectory = $scriptDirectory + "\watermark" 
[Int]$watermarkSize = 30                                                                                                                     ##Applies for both the width scaling and the height offset, note: !larger value is smaller text!
$wmText = "© RTV Sternet/Joey te Wierik"                                                                                                     ##Text to be watermarked
$wmFont = "Arial"                                                                                                                            ##Making the font bold/italic would be adding -Bold-Italic to the variable.
$wmPrefix = "watermark_"


#Create target directory
if (-not (Test-Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

#Get all files
#$files = Get-ChildItem -Path $scriptDirectory -Filter "*.jpg" -Recurse -Depth 0                                                             ## This code could be used to ONLY read jpg files in the current Folder (not subdirectories). If this is preferred, remove the # hashtag and place it before the line below to deactivate that line.
$files = Get-ChildItem -Path $scriptDirectory -Include ("*.png", "*.jpeg", "*.jpg", "*.tiff", "*.raw") -Exclude ("$wmPrefix*") -Recurse      ## Reading multiple file types means also reading all Subfolders (subdirectories), while skipping the already treated ones with the defined Prefix.


#Code to apply watermark from text for all files in same folder as photos, stored as "[Prefix][filename]"
ForEach($file in $files) {
    $fileName = $file.FullName
    $name = Get-ChildItem -Path $fileName -Name
    $outputName = $outputDirectory + "\" + $wmPrefix + $name
write $fileName
    [Int]$imageWidth = magick identify -format "%w" $fileName
    [Int]$imageHeight = magick identify -format "%h" $fileName
    [Int]$fontDimension = [Int]$imageWidth / [Int]$watermarkSize
    [Int]$fontOffset = [Int]$imageHeight / [Int]$watermarkSize
write $fontDimension
    magick $fileName -font $wmFont -fill "rgba(255,255,255,0.5" -pointsize $fontDimension -gravity south -annotate +0+$fontOffset $wmText $outputName
}

