cask "animeflow" do
  version "2.6.7"
  sha256 "4f4d7d76c68d486de670cc59b6d0b1cf2245dee3bd1ca13e132e0a34ccca78db"

  url "https://github.com/openAnimeFlow/AnimeFlow/releases/download/v#{version}/AnimeFlow-macos-#{version}.dmg"
  name "AnimeFlow"
  desc "Anime player with Bangumi sync and danmaku"
  homepage "https://web.ligg.top/"

  depends_on macos: :monterey

  app "anime_flow.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{appdir}}/anime_flow.app"]
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.FinderInfo", "{{appdir}}/anime_flow.app"]
  end

  zap trash: [
    "~/Library/Application Scripts/com.example.animeFlow",
    "~/Library/Application Support/com.example.animeFlow",
    "~/Library/Caches/com.example.animeFlow",
    "~/Library/Containers/com.example.animeFlow",
    "~/Library/HTTPStorages/com.example.animeFlow",
    "~/Library/Preferences/com.example.animeFlow.plist",
    "~/Library/Saved Application State/com.example.animeFlow.savedState",
    "~/Library/WebKit/com.example.animeFlow",
  ]
end
