cask "saoimageds9" do
  # NOTE: "9" is not a version number, but an intrinsic part of the product name
  arch arm: "arm64", intel: "x86"

  on_big_sur :or_older do
    version "8.5"
    sha256 arm:   "b50a92cc729e5054aaf511911a189dea9cd13c4f6685a53c404b77efbc071854",
           intel: "46917bdab7fd22cb4cfd85145e9813c59e03dc1468f961172ad5ca396616fbb4"

    url "https://ds9.si.edu/download/macosbigsur#{arch}/SAOImageDS9%20#{version}.dmg"
  end
  on_monterey :or_newer do
    version "8.8.1"
    sha256 "bb39e3678dfc571f361442125e90b2f144665cf324124de08f37bd4d0ed92c61"

    url "https://ds9.si.edu/download/macos_universal/SAOImageDS9%20#{version}.dmg"
  end

  name "SAOImage DS9"
  desc "Astronomical data visualisation tool"
  homepage "https://sites.google.com/cfa.harvard.edu/saoimageds9/home"

  livecheck do
    url "https://sites.google.com/cfa.harvard.edu/saoimageds9/download"
    regex(/href=.*?SAOImageDS9%20v?(\d+(?:\.\d+)+)\.dmg/i)
  end

  depends_on :macos

  app "SAOImageDS9.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/.ds9",
    "~/Library/Preferences/com.sao.SAOImageDS9.plist",
    "~/Library/Saved Application State/com.sao.SAOImageDS9.savedState",
  ]
end
