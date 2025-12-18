class YoutubeChat < Formula
  desc "YouTube CLI Companion - Ask any questions about video content"
  homepage "https://github.com/etikhonov-dev/homebrew-youtube-chat"
  version "1.3.2"
  license "CC-BY-NC-ND-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.3.2/youtube-chat-macos-arm64"
      sha256 "66342bebcfa432c7afe5714663610da6732e215a87c9b61dba19a92e0200f082"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.3.2/youtube-chat-macos-x64"
      sha256 "b2cb932d9fd177b97d5f21e42fa04312b9714c53166126a5949963de1d9e46cd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.3.2/youtube-chat-linux-arm64"
      sha256 "d2118b3adf9276d17c8df2c2dee5e05a68aa0c34b4a6cafc0dc9a29a9509613c"
    else
      url "https://github.com/etikhonov-dev/homebrew-youtube-chat/releases/download/v1.3.2/youtube-chat-linux-x64"
      sha256 "0797a1af7064ffb6c141543d008a4ed21064c9db70113ee880eba4efc07a7eb6"
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