class NtfyMac < Formula
  desc "Forward ntfy notifications to macOS Notification Center"
  homepage "https://github.com/jkrumm/ntfy-mac"
  version "1.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-mac-arm64"
      sha256 "346646f37f8b2bf6cb5ffd57c97d7515b30ac476527be969b4385557fd8c2c08" # arm64
    end

    on_intel do
      url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-mac-x64"
      sha256 "7cc5f9f0e3d813c255622982dbc7cc4edde447bf1ef0588be5049ae8df147c39" # x64
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

      Setup configures your ntfy server credentials and auto-starts the daemon —
      ignore the "brew services start" line below, setup handles it.
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
