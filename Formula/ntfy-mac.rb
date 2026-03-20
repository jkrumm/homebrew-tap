class NtfyMac < Formula
  desc "Forward ntfy notifications to macOS Notification Center"
  homepage "https://github.com/jkrumm/ntfy-mac"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-mac-arm64"
      sha256 "6cb4f4b3408103aaaf9aceec15aec64daedef29f932367956bf8bacbfccb4a5c" # arm64
    end

    on_intel do
      url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-mac-x64"
      sha256 "b22472c2187249b90171b953d214132bb8f1cd1f9543b82a6efa8d9303842a31" # x64
    end
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    bin.install "ntfy-mac-#{arch}" => "ntfy-mac"
  end

  def caveats
    <<~EOS
      To get started, run setup to configure your ntfy server and store credentials:
        ntfy-mac setup

      Then start ntfy-mac as a background service (auto-starts at login):
        brew services start jkrumm/tap/ntfy-mac
    EOS
  end

  service do
    run [opt_bin/"ntfy-mac"]
    keep_alive true
    log_path var/"log/ntfy-mac.log"
    error_log_path var/"log/ntfy-mac-error.log"
  end

  test do
    output = shell_output("#{bin}/ntfy-mac --version 2>&1")
    assert_match "ntfy-mac", output
  end
end
