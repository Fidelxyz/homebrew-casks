cask "easyeda" do
  arch arm: "arm64", intel: "x64"

  version "6.5.61"
  sha256 arm:   "0eac60bdbba1fb4f674e315607f4b381beff08ed0cce59354f42e1e1adaaa39e",
         intel: "61184ecf15862cf5356be587ad8a8623abbf7c0ca59f34e68ddf99da03fc1fd1"

  url "https://image.easyeda.com/files/easyeda-mac-#{arch}-#{version}.zip"
  name "EasyEDA"
  desc "PCB design tool"
  homepage "https://easyeda.com/"

  livecheck do
    url "https://easyeda.com/api/latestClientVersion"
    strategy :json do |json|
      json["result"]
    end
  end

  depends_on :macos

  app "easyeda-mac-#{arch}-#{version}/EasyEDA.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Application Support/EasyEDA",
    "~/Library/Logs/EasyEDA",
    "~/Library/Preferences/com.easyeda.editor.helper.plist",
    "~/Library/Preferences/com.easyeda.editor.plist",
    "~/Library/Saved Application State/com.easyeda.editor.savedState",
  ]
end
