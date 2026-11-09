cask "cinecred" do
  arch arm: "arm64", intel: "x86_64"

  version "1.9.1"
  sha256 arm:   "3badb6184c9d2b2eb7586682aa4ae0fa9285950b9458309f0bf43fc439c341be",
         intel: "c53ad6f61ca2131b44483eaa215875f04af2ceee54589f3809666e419fe78b2d"

  url "https://cinecred.com/dl/#{version}/cinecred-#{version}-#{arch}.pkg"
  name "Cinecred"
  desc "Film credits editor and renderer"
  homepage "https://cinecred.com/"

  livecheck do
    url "https://cinecred.com/dl/"
    regex(%r{href=["']?/dl/v?(\d+(?:\.\d+)+)/}i)
  end

  depends_on :macos

  pkg "cinecred-#{version}-#{arch}.pkg"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  uninstall pkgutil: "Cinecred"

  zap trash: [
    "~/Library/Application Support/Cinecred",
    "~/Library/Application Support/CrashReporter/Cinecred_*.plist",
    "~/Library/Preferences/Cinecred.plist",
  ]
end
