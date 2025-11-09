# Installation Guide

This guide covers all available methods to install YouTube CLI Companion.

## Table of Contents

- [Method 1: Standalone Binary (Recommended)](#method-1-standalone-binary-recommended)
- [Method 2: npm/npx](#method-2-npmnpx)
- [Method 3: Install from Source](#method-3-install-from-source)
- [Future: Homebrew](#future-homebrew)

---

## Method 1: Standalone Binary (Recommended)

Standalone binaries require **no dependencies** (no Node.js installation needed).

### Quick Install with Script

#### macOS / Linux / WSL

```bash
curl -fsSL https://raw.githubusercontent.com/etikhonov-dev/youtube-chat-releases/main/install.sh | bash
```

This script will:
- Detect your platform and architecture automatically
- Download the appropriate binary
- Install it to `/usr/local/bin/youtube-chat`
- Make it executable

#### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/etikhonov-dev/youtube-chat-releases/main/install.ps1 | iex
```

This script will:
- Detect your platform and architecture automatically
- Download the appropriate binary
- Install it to `C:\Program Files\youtube-chat\youtube-chat.exe`
- Add it to your PATH

### Manual Download

Download the latest binary for your platform from [GitHub Releases](https://github.com/etikhonov-dev/youtube-chat-releases/releases/latest):

**Available Binaries:**
- **macOS (Intel)**: `youtube-chat-macos-x64`
- **macOS (Apple Silicon)**: `youtube-chat-macos-arm64`
- **Linux (x64)**: `youtube-chat-linux-x64`
- **Linux (ARM64)**: `youtube-chat-linux-arm64`
- **Windows (x64)**: `youtube-chat-win-x64.exe`

#### Installation Steps (macOS/Linux)

1. Download the binary for your platform
2. Make it executable:
   ```bash
   chmod +x youtube-chat-*
   ```
3. Move it to a directory in your PATH:
   ```bash
   sudo mv youtube-chat-* /usr/local/bin/youtube-chat
   ```
4. Verify installation:
   ```bash
   youtube-chat --version
   ```

#### Installation Steps (Windows)

1. Download `youtube-chat-win-x64.exe`
2. Rename it to `youtube-chat.exe`
3. Move it to a directory in your PATH, or:
   - Create a folder: `C:\Program Files\youtube-chat\`
   - Move the binary there
   - Add `C:\Program Files\youtube-chat\` to your PATH

---

## Method 2: npm/npx

### Requirements

- Node.js v18 or higher
- npm (comes with Node.js)

### Option A: Quick Start with npx (No Installation)

Run directly without installing:

```bash
npx @etikhonov-dev/youtube-chat https://youtu.be/YF75cLE-6hI
```

Perfect for trying out the tool or one-time use.

### Option B: Global Installation

Install globally to use anywhere:

```bash
npm install -g @etikhonov-dev/youtube-chat
```

Then run:

```bash
youtube-chat https://youtu.be/YF75cLE-6hI
```

### Updating

To update to the latest version:

```bash
npm update -g @etikhonov-dev/youtube-chat
```

---

## Method 3: Install from Source

### For Users with npm Package

If you've installed via npm, you can access the source code in your global `node_modules`:

```bash
npm list -g @etikhonov-dev/youtube-chat
```

This will show you where the package is installed.

### For Contributors (Requires Repository Access)

**Note:** The source repository is private. This method is only for authorized contributors.

1. Clone the repository:
   ```bash
   git clone https://github.com/etikhonov-dev/youtube-chat.git
   cd youtube-chat
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Run in development mode:
   ```bash
   node index.js https://youtu.be/YF75cLE-6hI
   ```

4. (Optional) Build standalone binaries:
   ```bash
   npm run build
   ```

---

## Future: Homebrew

Homebrew support is planned for the future. This will enable easy installation on macOS and Linux:

```bash
# Coming soon!
brew install youtube-chat
```

Stay tuned for updates!

---

## Setting Up Your API Key

Regardless of installation method, you'll need a Google API key for Gemini:

### macOS / Linux / WSL

```bash
export GOOGLE_API_KEY='your_api_key_here'
```

To make it permanent, add this line to your `~/.bashrc`, `~/.zshrc`, or `~/.profile`:

```bash
echo "export GOOGLE_API_KEY='your_api_key_here'" >> ~/.bashrc
```

### Windows (PowerShell)

```powershell
[Environment]::SetEnvironmentVariable('GOOGLE_API_KEY', 'your-key-here', 'User')
```

This sets the environment variable permanently for your user account.

### Get Your API Key

Visit: https://aistudio.google.com/apikey

---

## Verifying Installation

After installation, verify it works:

```bash
youtube-chat --version
```

You should see the version number displayed.

## Need Help?

- Check the [main README](https://github.com/etikhonov-dev/youtube-chat-releases/README.md) for usage instructions
- Report issues on [GitHub](https://github.com/etikhonov-dev/youtube-chat-releases/issues)
- Visit the [npm package page](https://www.npmjs.com/package/@etikhonov-dev/youtube-chat)