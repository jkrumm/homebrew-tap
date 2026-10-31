class HerdrCore < Formula
  desc "Headless terminal core for coding agents (hc)"
  homepage "https://herdr.dev"
  # Bumped by dotfiles scripts/herdr-core-update.ts (newest release at least 24 h old); do not edit by hand.
  version "0.1.15"

  on_macos do
    on_arm do
      url "https://releases.herdr.dev/core/#{version}/herdr-core-macos-aarch64.tar.gz"
      sha256 "47eba8367e0626a1efced8795fcb03d5434b2541c5a84d78c50cc02c8fb49fc8" # herdr-core-arm
    end
    on_intel do
      url "https://releases.herdr.dev/core/#{version}/herdr-core-macos-x86_64.tar.gz"
      sha256 "55acac7e0ba75c829028655cd7e7964d138b10a03946fd73628508a2821b1118" # herdr-core-intel
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
