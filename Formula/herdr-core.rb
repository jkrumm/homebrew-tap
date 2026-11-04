class HerdrCore < Formula
  desc "Headless terminal core for coding agents (hc)"
  homepage "https://herdr.dev"
  # Bumped by dotfiles scripts/herdr-core-update.ts (newest release at least 24 h old); do not edit by hand.
  version "0.1.17"

  on_macos do
    on_arm do
      url "https://releases.herdr.dev/core/#{version}/herdr-core-macos-aarch64.tar.gz"
      sha256 "cedbd4d4d9ba1385588198dd4d3c67d2654478f33add5b6445d4d0eb9da5fcf3" # herdr-core-arm
    end
    on_intel do
      url "https://releases.herdr.dev/core/#{version}/herdr-core-macos-x86_64.tar.gz"
      sha256 "e2dc3211edb1f1c77d0e73dd76c1426636d71050f34a5303916a56d363d7062b" # herdr-core-intel
    end
  end

  def install
    bin.install "herdr-core"
    bin.install_symlink "herdr-core" => "hc"
  end

  def caveats
    <<~EOS
      The core runs as the LaunchAgent com.jkrumm.herdr-core (dotfiles: make herdr-core-setup),
      started through ~/.local/libexec/herdr-core-launcher, which holds the Full Disk Access grant.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hc --version")
  end
end
