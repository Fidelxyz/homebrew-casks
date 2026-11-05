cask "chromium-gost" do
  arch arm: "arm64", intel: "amd64"

  on_monterey :or_older do
    version "150.0.7871.224"
    sha256 arm:   "9bc80d7ecd9caf43459d89d4c4880f95aae333b4a73ab6e886b59018cae1e2e7",
           intel: "e4dbe5b029c0c688c5c077e5818a9e2ad00caad76feb697f6c8f9d3b016f709a"
    livecheck do
      skip "Legacy version"
    end
  end
  on_ventura :or_newer do
    version "156.0.8078.79"
    sha256 arm:   "fe024cf0c38d8ba62963d4bf7afa6e26a42de141f4090b4adbe8840ed962d71e",
           intel: "4830b26fdc7e5a03e9a3dce1c9569515b60b90c3396d5b89b2021599c185252c"
    livecheck do
      url :url
      strategy :github_latest
    end
  end

  url "https://github.com/deemru/Chromium-Gost/releases/download/#{version}/chromium-gost-#{version}-macos-#{arch}.tar.bz2"
  name "Chromium-Gost"
  desc "Browser based on Chromium with support for GOST cryptographic algorithms"
  homepage "https://github.com/deemru/Chromium-Gost"

  depends_on macos: :monterey

  app "Chromium-Gost.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Application Support/Chromium",
    "~/Library/Caches/Chromium",
    "~/Library/Preferences/ru.cryptopro.chromium-gost.plist",
  ]
end
