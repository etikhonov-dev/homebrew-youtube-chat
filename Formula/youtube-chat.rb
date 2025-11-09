class YoutubeChat < Formula
  desc "YouTube CLI Companion - Ask any questions about video content"
  homepage "https://github.com/etikhonov-dev/homebrew-youtube-chat"
  version "1.1.2-test"
  license "CC-BY-NC-ND-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.1.2-test/youtube-chat-macos-arm64"
      sha256 "d85214849c491697da67d4ffa8f7993299fc188b3e620ea2573c5d02ebd86f95"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.1.2-test/youtube-chat-macos-x64"
      sha256 "9c45ceb816a129d1414a3823e965dacccce7dc03dda5ef18f4ed26db5d619a18"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.1.2-test/youtube-chat-linux-arm64"
      sha256 "33df7079b074972a7298f181f49178558d7712ba38420afec63af96d2196eb37"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.1.2-test/youtube-chat-linux-x64"
      sha256 "632afd0e7741d73a9e8f964ac3b9cbbdd400580a50c080ff1a704e71a0a4ba00"
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
