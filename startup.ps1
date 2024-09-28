# Check if the project directory is provided
if (-not $args[0]) {
    Write-Host "Usage: .\init-chrome-extension.ps1 <path-to-project-directory>"
    exit
}

# Set the project directory from argument
$projectDir = $args[0]

# Create the project directory
New-Item -ItemType Directory -Force -Path $projectDir

# Create manifest.json
$manifestContent = @'
{
  "manifest_version": 3,
  "name": "My Chrome Extension",
  "version": "1.0",
  "description": "A simple Chrome extension.",
  "background": {
    "service_worker": "background.js"
  },
  "action": {
    "default_popup": "popup.html",
    "default_icon": "icon.png"
  },
  "permissions": [
    "storage",
    "activeTab",
    "scripting"
  ],
  "content_scripts": [
    {
      "matches": ["<all_urls>"],
      "js": ["content.js"]
    }
  ]
}
'@

$manifestContent | Out-File -FilePath "$projectDir\manifest.json" -Encoding UTF8

# Create background.js
"console.log('Background script loaded.');" | Out-File -FilePath "$projectDir\background.js"

# Create content.js
"console.log('Content script loaded.');" | Out-File -FilePath "$projectDir\content.js"

# Create popup.html
$popupContent = @'
<!DOCTYPE html>
<html>
  <head>
    <title>My Extension</title>
    <style>
      body { font-family: Arial, sans-serif; }
    </style>
    <link rel="stylesheet" href="styles.css">
  </head>
  <body>
    <h1>Hello from Popup</h1>
    <p>This is your Chrome extension popup.</p>
  </body>
</html>
'@

$popupContent | Out-File -FilePath "$projectDir\popup.html" -Encoding UTF8

# Create CSS file
$cssContent = @'
body {
  background-color: #f9f9f9;
  margin: 0;
  padding: 10px;
}
h1 {
  font-size: 20px;
  color: #333;
}
p {
  font-size: 14px;
}
'@

$cssContent | Out-File -FilePath "$projectDir\styles.css" -Encoding UTF8

# Create an icon placeholder
"icon file" | Out-File -FilePath "$projectDir\icon.png"

Write-Host "Chrome extension project initialized in $projectDir"
