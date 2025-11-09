class YoutubeChat < Formula
  desc "YouTube CLI Companion - Ask any questions about video content"
  homepage "https://github.com/etikhonov-dev/homebrew-youtube-chat"
  version "1.2.2"
  license "CC-BY-NC-ND-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.2/youtube-chat-macos-arm64"
      sha256 "025b2b07c38f281cbd137690951bade5cb2a1b1a418cb8471eeb07dc4550556f"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.2/youtube-chat-macos-x64"
      sha256 "ac9e6eb3389d539ee61ad48018a6660d86fe18926d9c1bf62bcd89cf7967b2b8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.2/youtube-chat-linux-arm64"
      sha256 "9e0fd33676aa72319854dc22901b67d1197f4dad4c8e9942acd5cf761ec454bb"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.2/youtube-chat-linux-x64"
      sha256 "ed9db549418b1735a3e48a716739c6a0802d900f3d90d09857ac085f7d0f1420"
    end
  end

  def install
    # Determine the downloaded binary name based on platform and architecture
    if OS.mac?
      binary_name = Hardware::CPU.arm? ? "youtube-chat-macos-arm64" : "youtube-chat-macos-x64"
    elsif OS.linux?
      binary_name = Hardware::CPU.arm? ? "youtube-chat-linux-arm64" : "youtube-chat-linux-x64"
    end

    # Install the binary
    bin.install binary_name => "youtube-chat"
  end

  def caveats
    <<~EOS
      You need to set up your Google API key to use youtube-chat:

        export GOOGLE_API_KEY='your_api_key_here'

      Get your API key at: https://aistudio.google.com/apikey

      To make it permanent, add the export command to your shell profile:
        ~/.zshrc (macOS)
        ~/.bashrc (Linux)
    EOS
  end

  test do
    # Test that the binary exists and is executable
    system "#{bin}/youtube-chat", "--version"
  end
end
