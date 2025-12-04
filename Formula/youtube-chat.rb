class YoutubeChat < Formula
  desc "YouTube CLI Companion - Ask any questions about video content"
  homepage "https://github.com/etikhonov-dev/homebrew-youtube-chat"
  version "1.3.1"
  license "CC-BY-NC-ND-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.3.1/youtube-chat-macos-arm64"
      sha256 "163c36a2356b2d3f9dc6a81f2e58bc54134414d8d837b6df7f1b16fae003ffbe"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.3.1/youtube-chat-macos-x64"
      sha256 "d9f35c6362a5a6ecec8a154494a8634c735fb42c880219383b8a8cd5650cb573"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.3.1/youtube-chat-linux-arm64"
      sha256 "dd42e494191abe40e776da5e0b3fa38457e31c9b23d912388e86ec18262a55a1"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.3.1/youtube-chat-linux-x64"
      sha256 "962051c64e81cba702f0faab505c9b9b7f77408ac981045dfc2404884d0080cb"
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