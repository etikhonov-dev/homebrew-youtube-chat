class YoutubeChat < Formula
  desc "YouTube CLI Companion - Ask any questions about video content"
  homepage "https://github.com/etikhonov-dev/homebrew-youtube-chat"
  version "1.2.6"
  license "CC-BY-NC-ND-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.6/youtube-chat-macos-arm64"
      sha256 "e48286239870f7d200ca65e45d367b2a1a3b2c95fd662d0d2ee6d04d0c4476b0"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.6/youtube-chat-macos-x64"
      sha256 "05875b053a95708d14c12ca77082064d8aa9b301f57eb04ad78dcc789a5543f6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.6/youtube-chat-linux-arm64"
      sha256 "2356277cee15ff00e0435942fba01ed2339e6839fe07df6ad43c2be22b5816d2"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.2.6/youtube-chat-linux-x64"
      sha256 "b75af70c55b8e5dc1762dd3118a4e67576a7f0545b112641eb9c6359e7e6193f"
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
