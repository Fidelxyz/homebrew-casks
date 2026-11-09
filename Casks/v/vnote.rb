cask "vnote" do
  version "4.14.1"

  on_monterey :or_older do
    sha256 "97abd1b66f87009e774f3fdea49b678dfbe3589ee87e7eea883b4493e2c6f569"

    url "https://github.com/vnotex/vnote/releases/download/v#{version}/VNote-#{version}-mac-universal-macos12.dmg"
  end
  on_ventura :or_newer do
    sha256 "efa3de3b93341294de768d8c8f9b51de43d088aa2ae6cb5b61991fc73f5ce120"

    url "https://github.com/vnotex/vnote/releases/download/v#{version}/VNote-#{version}-mac-universal.dmg"
  end

  name "VNote"
  desc "Note-taking platform"
  homepage "https://docs.vnote.fun/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "VNote.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Application Support/VNote",
    "~/Library/Preferences/com.vnotex.vnote.plist",
    "~/Library/Preferences/VNote",
  ]
end
