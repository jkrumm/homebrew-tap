class NtfyMac < Formula
  desc "Forward ntfy notifications to macOS Notification Center"
  homepage "https://github.com/jkrumm/ntfy-mac"
  version "1.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-mac-arm64"
      sha256 "43b218e56f2bb37b7b0cb86168207d20aeb2058bc96cf19cd7c311685c015770" # arm64
    end

    on_intel do
      url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/ntfy-mac-x64"
      sha256 "951b204efd9fc1ca2c9cb964b9455085a3df7ab3314699fdae0ff4d00280a643" # x64
    end
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    bin.install "ntfy-mac-#{arch}" => "ntfy-mac"
  end

  def caveats
    <<~EOS
      🚀 Get started by running setup — this configures your ntfy server,
         stores credentials in macOS Keychain, and starts the background service:

           ntfy-mac setup
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
