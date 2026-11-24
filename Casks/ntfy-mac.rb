cask "ntfy-mac" do
  version "2.1.1"
  sha256 "f212cb90b8e23a2fae54d77262b627ef493b8b3ed35761ed588619417f5ae356"

  url "https://github.com/jkrumm/ntfy-mac/releases/download/v#{version}/NtfyMac-#{version}.zip"
  name "ntfy-mac"
  desc "Client and CLI for ntfy servers"
  homepage "https://github.com/jkrumm/ntfy-mac"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "NtfyMac.app"
  binary "#{appdir}/NtfyMac.app/Contents/MacOS/ntfy-mac"

  # The formula this cask replaces told users to link the app into ~/Applications. Once the formula
  # is gone that link dangles and Launch Services would list a second, broken copy.
  preflight_steps do
    remove "Applications/NtfyMac.app", base: :home, symlink_target_contains: "/ntfy-mac/"
  end

  uninstall quit: "com.jkrumm.ntfy-mac"

  zap trash: [
    "~/.config/ntfy-mac",
    "~/.local/share/ntfy-mac",
    "~/Library/Application Support/ntfy-mac",
    "~/Library/Caches/com.jkrumm.ntfy-mac",
    "~/Library/Preferences/com.jkrumm.ntfy-mac.plist",
    "~/Library/Saved Application State/com.jkrumm.ntfy-mac.savedState",
  ]
end
