class HerdrCore < Formula
  desc "Headless terminal core for coding agents (hc)"
  homepage "https://herdr.dev"
  # Bumped by dotfiles scripts/herdr-core-update.ts (newest release at least 24 h old); do not edit by hand.
  version "0.1.16"

  on_macos do
    on_arm do
      url "https://releases.herdr.dev/core/#{version}/herdr-core-macos-aarch64.tar.gz"
      sha256 "698d8f0c44f4e4b15fec174d52a39d57a014cfd71added44b53a0753b469d0fd" # herdr-core-arm
    end
    on_intel do
      url "https://releases.herdr.dev/core/#{version}/herdr-core-macos-x86_64.tar.gz"
      sha256 "6af081cdb35c8612c5752d3f64c6a378e6a0313968b6d4fbc4c03c95691b2872" # herdr-core-intel
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
