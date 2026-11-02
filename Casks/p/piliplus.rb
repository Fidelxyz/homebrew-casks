cask "piliplus" do
  version "2.2.0,5580"
  sha256 "89f1d78c141b6653292442c149cea0f5bb4cecdd1d8496418e26b3ebcb0eecbc"

  url "https://github.com/bggRGjQaUbCoE/PiliPlus/releases/download/#{version.csv.first}/PiliPlus_macos_#{version.csv.first.major_minor_patch}%2B#{version.csv.second}.dmg"
  name "PiliPlus"
  desc "Third-party Bilibili client"
  homepage "https://github.com/bggRGjQaUbCoE/PiliPlus"

  livecheck do
    url :url
    regex(/^PiliPlus[._-]macos[._-]v?(\d+(?:\.\d+)+)\+(\d+)\.dmg$/i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["name"]&.match(regex)
        next if match.blank?

        "#{json["tag_name"]},#{match[2]}"
      end
    end
  end

  depends_on macos: :monterey

  app "PiliPlus.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Application Scripts/com.example.piliplus",
    "~/Library/Application Support/com.example.piliplus",
    "~/Library/Caches/com.example.piliplus",
    "~/Library/Containers/com.example.piliplus",
    "~/Library/HTTPStorages/com.example.piliplus",
    "~/Library/Preferences/com.example.piliplus.plist",
    "~/Library/Saved Application State/com.example.piliplus.savedState",
    "~/Library/WebKit/com.example.piliplus",
  ]
end
