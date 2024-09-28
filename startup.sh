#!/bin/bash

# Check if the project directory is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <path-to-project-directory>"
    exit 1
fi

# Set the project directory from argument
PROJECT_DIR="$1"

# Create the project directory
mkdir -p "$PROJECT_DIR"

# Create manifest.json
cat <<EOL > "$PROJECT_DIR/manifest.json"
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
EOL

# Create background script
echo 'console.log("Background script loaded.");' > "$PROJECT_DIR/background.js"

# Create content script
echo 'console.log("Content script loaded.");' > "$PROJECT_DIR/content.js"

# Create popup HTML
cat <<EOL > "$PROJECT_DIR/popup.html"
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
EOL

# Create CSS file
cat <<EOL > "$PROJECT_DIR/styles.css"
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
EOL

# Create an icon placeholder
echo 'icon file' > "$PROJECT_DIR/icon.png"

echo "Chrome extension project initialized in $PROJECT_DIR"
