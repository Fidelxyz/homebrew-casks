cask "cinecred" do
  arch arm: "arm64", intel: "x86_64"
  url_end = on_system_conditional macos: "pkg", linux: "appimage"

  version "1.9.1"
  sha256 arm:          "3badb6184c9d2b2eb7586682aa4ae0fa9285950b9458309f0bf43fc439c341be",
         intel:        "c53ad6f61ca2131b44483eaa215875f04af2ceee54589f3809666e419fe78b2d",
         x86_64_linux: "13e93988e949c1ee34b4e6fc484516bd4f271094a77cfd4b66348ed1658c175c"

  on_macos do
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
  on_linux do
    depends_on arch: :x86_64

    app_image "cinecred-#{version}-x86_64.appimage", target: "Cinecred.AppImage"

    zap trash: "~/.config/cinecred"
  end

  url "https://cinecred.com/dl/#{version}/cinecred-#{version}-#{arch}.#{url_end}"
  name "Cinecred"
  desc "Film credits editor and renderer"
  homepage "https://cinecred.com/"

  livecheck do
    url "https://cinecred.com/dl/api/v1/components"
    strategy :json do |json|
      json["components"]&.map { |item| item["version"] }
    end
  end
end
