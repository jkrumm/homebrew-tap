class Clawbar < Formula
  desc "Menu-bar app for Claude Max usage monitoring"
  homepage "https://github.com/jkrumm/clawbar"
  url "https://github.com/jkrumm/clawbar/archive/refs/tags/v0.1.0.tar.gz"
  version "0.1.0"
  sha256 "87982c30a27c4998db9332172f17ac4fe9440b33575fd2e7c8bed552d60fc9ca"
  license "MIT"

  # Swift 6 toolchain ships with Xcode Command Line Tools, which Homebrew
  # itself already requires — no separate Xcode/swift dependency to declare.
  depends_on :macos

  def install
    cd "apps/clawbar" do
      system "swift", "build", "-c", "release", "--disable-sandbox"
    end

    system "scripts/bundle.sh", "apps/clawbar/.build/release/Clawbar", "dist", version.to_s

    libexec.install "dist/Clawbar.app"

    (bin/"clawbar").write <<~SH
      #!/bin/bash
      set -euo pipefail
      APP="#{libexec}/Clawbar.app"

      case "${1:-open}" in
        --version)
          exec "$APP/Contents/MacOS/Clawbar" --version
          ;;
        open)
          exec open "$APP"
          ;;
        *)
          echo "usage: clawbar [open|--version]" >&2
          exit 1
          ;;
      esac
    SH
  end

  def caveats
    <<~EOS
      Clawbar was built from source and signed ad hoc, so the first launch
      triggers a one-time macOS keychain prompt when it reads your Claude Code
      credentials — choose "Always Allow" and it won't ask again.

      Launch it:
        clawbar

      Launch at login is configured inside the app (Settings → General),
      not via `brew services`.
    EOS
  end

  test do
    output = shell_output("#{bin}/clawbar --version 2>&1")
    assert_match version.to_s, output
  end
end
