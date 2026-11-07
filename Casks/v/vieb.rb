cask "vieb" do
  arch arm: "arm64-"

  version "12.11.0"
  sha256 arm:   "32d4c64d8a0d8d55349225c7b1c6f7d19369fc48567f3e8103e5efff12a83dfe",
         intel: "d525dafac422c3602a92be9d1a176370e07554467a1073f86226f75f2707ea74"

  url "https://github.com/Jelmerro/Vieb/releases/download/#{version}/Vieb-#{version}-#{arch}mac.zip"
  name "Vieb"
  desc "Vim Inspired Electron Browser"
  homepage "https://vieb.dev/"

  depends_on macos: :ventura

  app "Vieb.app"
  command_wrapper "vieb",
                  executable: "#{appdir}/Vieb.app/Contents/MacOS/Vieb"

  postflight_steps do
    run "/bin/chmod", args: ["-R", "+w", "{{staged_path}}/.homebrew-command-wrappers"]
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Application Support/Vieb",
    "~/Library/Caches/Vieb",
  ]
end
