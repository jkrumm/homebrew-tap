class NtfyMac < Formula
  desc "Forward ntfy notifications to macOS Notification Center"
  homepage "https://github.com/jkrumm/ntfy-mac"
  version "1.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-mac-arm64"
      sha256 "dfef35ff821147a7344dcdc0107d52a63da10b36fc716181b6659a4ccb18fab0" # arm64
    end

    on_intel do
      url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-mac-x64"
      sha256 "ea315d5d3f219ada9d1795dc708069ceb075dd4f56c39059444a9b436089ead8" # x64
    end
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    bin.install "ntfy-mac-#{arch}" => "ntfy-mac"
  end

  def caveats
    <<~EOS
      Run setup to configure your ntfy server and start the background service:

        👉 ntfy-mac setup

      Setup stores your credentials in ~/.config/ntfy-mac/config.json and
      auto-starts the daemon — ignore the "brew services start" line below,
      setup handles it.
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
