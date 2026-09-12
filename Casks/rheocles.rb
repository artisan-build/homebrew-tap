cask "rheocles" do
  # 0.0.0 and an all-zero digest on purpose: nothing has shipped. This file is
  # the target bump-cask.sh rewrites on the first v* release; until then the
  # URL 404s and the checksum can never match, so `brew install` refuses.
  version "0.1.0"
  sha256 "ffae4ae8c4716f5994be34cd56bd867b91127ce445b863c12bc3a5d77ebd48d1"

  # The asset name carries no version on purpose, so that
  # /releases/latest/download/Rheocles.dmg keeps resolving for the website.
  # The tag in the path is what makes this URL version-stable for a cask.
  url "https://github.com/artisan-build/rheocles/releases/download/v#{version}/Rheocles.dmg"
  name "Rheocles"
  desc "Records every input stream to its own file, on one cue"
  homepage "https://rheocles.com/"

  # Apple Silicon only. Without this, brew installs cheerfully on an Intel Mac
  # and the failure arrives as a crash instead of a refusal.
  depends_on arch: :arm64
  # macOS 15 for SCRecordingOutput and the Core Audio process taps.
  depends_on macos: :sequoia

  app "Rheocles.app"

  # A menu bar app keeps running after the bundle is trashed; quit it first so
  # the uninstall is not a half-measure with a stale process holding devices.
  uninstall quit: "build.artisan.rheocles"

  zap trash: [
    "~/Library/Caches/build.artisan.rheocles",
    "~/Library/Preferences/build.artisan.rheocles.plist",
  ]

  caveats <<~EOS
    Rheocles runs in the menu bar — it has no Dock icon and no window until
    you click it.

    On first use it asks for camera, microphone and screen recording access
    for each kind of stream you arm. It cannot record a stream until that
    permission is granted.
  EOS
end
