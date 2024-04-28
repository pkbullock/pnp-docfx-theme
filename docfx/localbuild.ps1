#!/usr/bin/env pwsh

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 2.0

# Download and copy docfx to the local folder: c:\git\docfx\2.76.0
# Release: 
c:\git\docfx\2.76.0\docfx build docfx.json --warningsAsErrors $args

Write-Host "DocFX build completed."
Write-Host "Navigate to the output folder: c:\git\pnpcore\main\docfx\_site and run http-server -c-1"
Write-Host "Open your browser and navigate to http://localhost:8080"