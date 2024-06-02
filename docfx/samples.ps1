Write-Host "Combining all sample.json files into a single file samples.json"

# Get all sample.json files in scripts/<sample>/assets folders
$jsonFiles = Get-ChildItem -Path ..\scripts -Filter sample.json -Recurse | Where-Object { $_.DirectoryName -like "*\assets" }

# Initialize an empty array to hold the content of all json files
$jsonContent = @()

# Loop through each json file
foreach ($file in $jsonFiles) {
    # Get the content of the file
    $content = Get-Content $file.FullName | ConvertFrom-Json -Depth 6

    # Here the information can be reduced to the necessary information only to reduce file size e.g.,
    # name, title, url, creationDateTime, updateDateTime, shortDescription,products,categories, tags, metadata, thumbnails, authors

    # Add the content to the array
    $jsonContent += $content
}

# Convert the array to json
$combinedJson = $jsonContent | ConvertTo-Json -Depth 6

# Write the combined json to a file
$combinedJson | Out-File -FilePath .\samples.json

Write-Host "Combined all sample.json files" -ForegroundColor Green