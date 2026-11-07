cask "freetube" do
  arch arm: "arm64", intel: "x64"

  on_big_sur :or_older do
    version "0.23.15"
    sha256 arm:   "6a25f689ecf0382c9b3c98be308f5d97eda1c362035dd1d715307a25ab68320a",
           intel: "ebade3bc4b3cb7c994201cf1bd50459c33c8b4d85ae0e714b2c5a32612c70e69"

    url "https://github.com/FreeTubeApp/FreeTube/releases/download/v#{version}-beta/freetube-#{version}-beta-mac-#{arch}.dmg"

    livecheck do
      skip "Legacy version"
    end
  end
  on_monterey do
    version "0.25.3"
    sha256 arm:   "2b445d64f5e56a873debea50c785cd41400bdabc387f0d67fc7be745b2b9146e",
           intel: "40fb6c671ec75905e035968ec0c14bfe717643730af80536e625d191455f49bf"

    url "https://github.com/FreeTubeApp/FreeTube/releases/download/v#{version}-beta/freetube-#{version}-beta-mac-#{arch}.dmg"

    livecheck do
      skip "Legacy version"
    end
  end
  on_ventura :or_newer do
    version "0.26.0"
    sha256 arm:   "16b49e40297e35806aec173d2f2a9f2bf85e1e377207d40ac365c59e7a73a8b2",
           intel: "2e9343898c6a33acf7e48f81c24d97c7fe45cb7c942ab6e27c509118a03b18cb"

    url "https://github.com/FreeTubeApp/FreeTube/releases/download/v#{version}-beta/freetube-#{version}-beta-mac-#{arch}.dmg"

    livecheck do
      url :url
      regex(/^v?(\d+(?:\.\d+)+)/i)
    end
  end

  name "FreeTube"
  desc "YouTube player focusing on privacy"
  homepage "https://freetubeapp.io/"

  depends_on :macos

  app "FreeTube.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  uninstall quit: "io.freetubeapp.freetube"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/io.freetubeapp.freetube.sfl*",
    "~/Library/Application Support/FreeTube",
    "~/Library/Preferences/io.freetubeapp.freetube.plist",
    "~/Library/Saved Application State/io.freetubeapp.freetube.savedState",
  ]
end
