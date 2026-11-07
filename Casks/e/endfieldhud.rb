cask "endfieldhud" do
  version "1.3.0,19"
  sha256 "f4894df02d7f1f7a0b22a30d16e6aec3ee6864e7417af1fdeacc119e58cf9886"

  url "https://github.com/DDDuoDuo/EndfieldHUD/releases/download/v#{version.csv.first}/EndfieldHUD-#{version.csv.first}-build#{version.csv.second}-macOS.dmg"
  name "EndfieldHUD"
  desc "Endfield-inspired menu bar HUD for notes, files and desktop tools"
  homepage "https://github.com/DDDuoDuo/EndfieldHUD"

  livecheck do
    url :url
    regex(/^EndfieldHUD[._-]v?(\d+(?:\.\d+)+)[._-]build(\d+)[._-]macOS\.dmg$/i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["name"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  auto_updates true
  depends_on :macos

  app "EndfieldHUD.app"

  uninstall launchctl: "io.github.endfieldcharge.EndfieldCharge",
            quit:      "io.github.endfieldcharge.EndfieldCharge"

  zap trash: [
    "~/Library/Application Support/EndfieldCharge",
    "~/Library/Caches/io.github.endfieldcharge.EndfieldCharge",
    "~/Library/HTTPStorages/io.github.endfieldcharge.EndfieldCharge",
    "~/Library/LaunchAgents/io.github.endfieldcharge.EndfieldCharge.plist",
    "~/Library/Preferences/io.github.endfieldcharge.EndfieldCharge.plist",
    "~/Library/Saved Application State/io.github.endfieldcharge.EndfieldCharge.savedState",
    "~/Library/WebKit/io.github.endfieldcharge.EndfieldCharge",
  ]
end
