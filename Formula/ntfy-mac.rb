class NtfyMac < Formula
  desc "Forward ntfy notifications to macOS Notification Center"
  homepage "https://github.com/jkrumm/ntfy-mac"
  version "1.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-mac"
      sha256 "f71d26a32d26b7bbe65b4871f2da61bda210055e2167564e07f67e542e9580e4" # ntfy-mac

      resource "ntfy-notify" do
        url "https://github.com/jkrumm/ntfy-mac/releases/download/v1.10.0/ntfy-notify.app.tar.gz"
        sha256 "8146bf003f08e777b0da09c3a475c179a80e4e4e9c3154f75e8f676dd85285ca" # ntfy-notify
      end
    end
  end

  def install
    bin.install "ntfy-mac"

    # Homebrew peels the single top-level directory from the tarball, so the
    # stage block runs inside ntfy-notify.app/ (not alongside it). Install the
    # bundle contents into the correct destination path.
    resource("ntfy-notify").stage do
      (libexec/"ntfy-notify.app").install Dir["*"]
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
