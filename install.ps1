# YouTube CLI Companion Installation Script for Windows
# Supports Windows 10 and 11 (x64)

$ErrorActionPreference = "Stop"

$REPO = "etikhonov-dev/youtube-chat-releases"
$BINARY_NAME = "youtube-chat"
$INSTALL_DIR = "$env:LOCALAPPDATA\Programs\youtube-chat"

# Print colored messages
function Print-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Green
}

function Print-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Print-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

# Detect architecture
function Get-Platform {
    $arch = $env:PROCESSOR_ARCHITECTURE

    if ($arch -ne "AMD64") {
        Print-Error "Unsupported architecture: $arch. Only x64 is supported."
        exit 1
    }

    $platform = "win-x64"
    Print-Info "Detected platform: $platform"
    return $platform
}

# Get latest release version
function Get-LatestVersion {
    Print-Info "Fetching latest release..."

    try {
        $response = Invoke-RestMethod -Uri "https://api.github.com/repos/$REPO/releases/latest"
        $version = $response.tag_name

        if ([string]::IsNullOrEmpty($version)) {
            throw "Version is empty"
        }

        Print-Info "Latest version: $version"
        return $version
    }
    catch {
        Print-Error "Failed to fetch latest version: $_"
        exit 1
    }
}

# Download and install binary
function Install-Binary {
    param(
        [string]$Version,
        [string]$Platform
    )

    $downloadUrl = "https://github.com/$REPO/releases/download/$Version/$BINARY_NAME-$Platform.exe"
    $tempFile = "$env:TEMP\$BINARY_NAME.exe"

    Print-Info "Downloading from: $downloadUrl"

    try {
        Invoke-WebRequest -Uri $downloadUrl -OutFile $tempFile -UseBasicParsing
    }
    catch {
        Print-Error "Failed to download binary: $_"
        Print-Info "You can download manually from: https://github.com/$REPO/releases/latest"
        exit 1
    }

    # Create installation directory
    if (-not (Test-Path $INSTALL_DIR)) {
        New-Item -ItemType Directory -Path $INSTALL_DIR -Force | Out-Null
    }

    # Move binary to installation directory
    $installPath = Join-Path $INSTALL_DIR "$BINARY_NAME.exe"
    Move-Item -Path $tempFile -Destination $installPath -Force

    Print-Info "Successfully installed to $installPath"
    return $installPath
}

# Add to PATH if not already present
function Add-ToPath {
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

    if ($currentPath -notlike "*$INSTALL_DIR*") {
        Print-Info "Adding $INSTALL_DIR to user PATH..."

        $newPath = "$currentPath;$INSTALL_DIR"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")

        # Update current session PATH
        $env:Path = "$env:Path;$INSTALL_DIR"

        Print-Info "Added to PATH. You may need to restart your terminal."
    }
    else {
        Print-Info "$INSTALL_DIR is already in PATH"
    }
}

# Verify installation
function Test-Installation {
    Print-Info "Verifying installation..."

    # Refresh PATH for current session
    $env:Path = [Environment]::GetEnvironmentVariable("Path", "User") + ";" + [Environment]::GetEnvironmentVariable("Path", "Machine")

    $command = Get-Command $BINARY_NAME -ErrorAction SilentlyContinue

    if ($command) {
        Print-Info "Installation successful!"
        Print-Info "Run '$BINARY_NAME --help' to get started"
        Write-Host ""
        Print-Warning "Don't forget to set your GOOGLE_API_KEY environment variable!"
        Print-Info "Get your API key at: https://aistudio.google.com/app/apikey"
        Write-Host ""
        Print-Info "To set the API key permanently, run:"
        Write-Host "    [Environment]::SetEnvironmentVariable('GOOGLE_API_KEY', 'your-key-here', 'User')" -ForegroundColor Cyan
    }
    else {
        Print-Warning "Installation completed, but command not found in PATH."
        Print-Info "Please restart your terminal and try again."
        Print-Info "If the issue persists, manually add this to your PATH: $INSTALL_DIR"
    }
}

# Main installation flow
function Main {
    Write-Host "YouTube CLI Companion Installer" -ForegroundColor Cyan
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host ""

    $platform = Get-Platform
    $version = Get-LatestVersion
    Install-Binary -Version $version -Platform $platform
    Add-ToPath
    Test-Installation
}

# Run main installation
Main