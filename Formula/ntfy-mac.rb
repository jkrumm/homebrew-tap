class NtfyMac < Formula
  desc "Forward ntfy notifications to macOS Notification Center"
  homepage "https://github.com/jkrumm/ntfy-mac"
  version "1.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-mac"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000" # ntfy-mac

      resource "ntfy-notify" do
        url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-notify.app.tar.gz"
        sha256 "0000000000000000000000000000000000000000000000000000000000000000" # ntfy-notify
      end
    end
  end

  def install
    bin.install "ntfy-mac"

    resource("ntfy-notify").stage do
      libexec.install "ntfy-notify.app"
    end
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
