cask "openmsx-emulator" do
  arch arm: "aarch64", intel: "x86_64"

  version "22.0"
  sha256 arm:   "3138c3f7034ac914d8823bc024f759569f64fdcca4c5577292b1c83ba6c2812f",
         intel: "e01ca5c9eaf48771b4ebed34a8e7c987150629a5d705bcfa98123a9bc578cfdf"

  url "https://github.com/openMSX/openMSX/releases/download/RELEASE_#{version.dots_to_underscores}/openmsx-#{version}-mac-#{arch}-bin.dmg"
  name "openMSX"
  desc "MSX emulator"
  homepage "https://openmsx.org/"

  livecheck do
    url :url
    regex(/^RELEASE[._-]v?(\d+(?:[._]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("_", ".") }
    end
  end

  depends_on macos: :ventura

  app "openMSX.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: "~/.openMSX"
end
