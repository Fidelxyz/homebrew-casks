cask "ultrastardeluxe" do
  arch arm: "ARM", intel: "x86"

  version "2026.11.0"
  sha256 arm:   "0cb2edf3789c5951bebde53d648149527822d1ca12e344947638f866dde57362",
         intel: "95047cf8c3b3f18e98a99dbb73482f16f9a8fee747af6ec0dd8c0e434154f508"

  url "https://github.com/UltraStar-Deluxe/USDX/releases/download/v#{version}/UltraStarDeluxe-mac-#{arch}-#{version}.dmg"
  name "UltraStar Deluxe"
  desc "Karaoke game"
  homepage "https://usdx.eu/"

  depends_on :macos

  app "UltraStar Deluxe.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  uninstall quit: "org.ultrastardeluxe.ultrastardeluxe"

  zap trash: "~/Library/Application Support/UltraStarDeluxe1.3"
end
