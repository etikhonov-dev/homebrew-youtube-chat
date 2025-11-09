class YoutubeChat < Formula
  desc "YouTube CLI Companion - Ask any questions about video content"
  homepage "https://github.com/etikhonov-dev/homebrew-youtube-chat"
  version "1.2.3"
  license "CC-BY-NC-ND-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.3/youtube-chat-macos-arm64"
      sha256 "a05811f9082c8a786ccd1e1ee9ce496b534d4d38521c1d880906271ed1283221"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.3/youtube-chat-macos-x64"
      sha256 "6fdf9a91d156ec8388ed4946c0beb12169902213f8a0afdac8545cba425dc53d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.3/youtube-chat-linux-arm64"
      sha256 "2e82f0da5797d384d68a974b911accf21a008487a1666f889109250667aa2f1e"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.3/youtube-chat-linux-x64"
      sha256 "ac60b5627ffcd806ec1f7442d92c689d1923529d688947b6dab7d0742bb31246"
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
