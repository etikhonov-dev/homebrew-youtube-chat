class YoutubeChat < Formula
  desc "YouTube CLI Companion - Ask any questions about video content"
  homepage "https://github.com/etikhonov-dev/homebrew-youtube-chat"
  version "1.2.0"
  license "CC-BY-NC-ND-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.0/youtube-chat-macos-arm64"
      sha256 "f9a7c6b9f4279c60b9d11b802fcce5f815b2efdb127937843216ba2da9d8d468"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.0/youtube-chat-macos-x64"
      sha256 "e6d38a73ade60aee7b1463edaab8a23a589a8f49f841ba185ff1b888f5b24d89"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.0/youtube-chat-linux-arm64"
      sha256 "0c674a3eedbab7b84050313bd00977a304bdf7341209519e41ca58b0095193ac"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.0/youtube-chat-linux-x64"
      sha256 "ee9daffdc15c53ee214a467449e485d33ac6cefe17949d3ccb14ac38d62743d1"
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
