cask "unity-android-support-for-editor" do
  version "6000.6.8f1,237b6593792b"
  sha256 "7137d20338d1844e30b8997a8f6359a648aabf78c60a580f740b3dc404bc11ea"

  url "https://download.unity3d.com/download_unity/#{version.csv.second}/MacEditorTargetInstaller/UnitySetup-Android-Support-for-Editor-#{version.csv.first}.pkg"
  name "Unity Android Build Support"
  desc "Android target support for Unity"
  homepage "https://unity.com/products"

  livecheck do
    cask "unity"
  end

  depends_on cask: "unity"
  depends_on :macos

  pkg "UnitySetup-Android-Support-for-Editor-#{version.csv.first}.pkg"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  uninstall pkgutil: "com.unity3d.AndroidPlayer-#{version.csv.first}"
end
