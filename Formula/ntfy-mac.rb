class NtfyMac < Formula
  desc "Native macOS client and CLI for ntfy servers"
  homepage "https://github.com/jkrumm/ntfy-mac"
  url "https://github.com/jkrumm/ntfy-mac/releases/download/v2.0.1/ntfy-mac-2.0.1-arm64.tar.gz"
  version "2.0.1"
  sha256 "b8eea645962769d2131d96e682732eef61ca491b092fac68d2a19a3d4d55bbc3"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    prefix.install "NtfyMac.app"
    bin.install_symlink prefix/"NtfyMac.app/Contents/MacOS/ntfy-mac" => "ntfy-mac"
  end

  def caveats
    <<~EOS
      The app is installed at:
        #{opt_prefix}/NtfyMac.app

      Link it into ~/Applications so Spotlight and Login Items find it. If
      ~/Applications/NtfyMac.app is already a real folder (a curl install), delete that
      folder first; your config and history stay. Then:
        mkdir -p ~/Applications && ln -sfn #{opt_prefix}/NtfyMac.app ~/Applications/NtfyMac.app

      Keep one install per Mac: `ntfy-mac doctor` warns about a second copy.
      This copy is managed by Homebrew: update it with `brew upgrade ntfy-mac`.

      Then run `ntfy-mac setup`, or open the app.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ntfy-mac --version")
  end
end
