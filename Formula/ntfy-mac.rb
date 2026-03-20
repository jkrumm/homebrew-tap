class NtfyMac < Formula
  desc "Forward ntfy notifications to macOS Notification Center"
  homepage "https://github.com/jkrumm/ntfy-mac"
  version "1.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-mac-arm64"
      sha256 "d0db96edf3701baf4dddc35b600223350fbc71d7c255c8dbe12791e53560685a" # arm64
    end

    on_intel do
      url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-mac-x64"
      sha256 "f2acb191e63be5b08fd31b22ddd384b728cc6794d7dad43cf5d42c6219f4c3d0" # x64
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
