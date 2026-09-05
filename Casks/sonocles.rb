cask "sonocles" do
  version "0.1.2"
  sha256 "f86cc0493bf6bc6502a74be7203f3211df96fcd262e20fb449ef9a1fe9d87a4a"

  # The asset name carries no version on purpose, so that
  # /releases/latest/download/Sonocles.dmg keeps resolving for the website.
  # The tag in the path is what makes this URL version-stable for a cask.
  url "https://github.com/artisan-build/sonocles/releases/download/v#{version}/Sonocles.dmg"
  name "Sonocles"
  desc "On-device speech-to-text that streams words while you are still saying them"
  homepage "https://sonocles.com"

  # Apple Silicon only — recognition runs on the Neural Engine. Without this,
  # brew installs cheerfully on an Intel Mac and the failure arrives as a
  # crash instead of a refusal.
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Sonocles.app"

  # The model cache is the reason this stanza matters: it is hundreds of
  # megabytes, it lives nowhere anyone would look, and a plain uninstall
  # leaves it behind forever. Note it is keyed to FluidAudio rather than to
  # us — if another FluidAudio app is ever installed here, this zaps its
  # models too.
  zap trash: [
    "~/Library/Application Support/FluidAudio",
    "~/Library/Caches/build.artisan.sonocles",
    "~/Library/Preferences/build.artisan.sonocles.plist",
  ]

  caveats <<~EOS
    Sonocles runs in the menu bar — it has no Dock icon and no window until
    you click it.

    On first launch it downloads speech models (~219 MB, about 428 MB once
    compiled for the Neural Engine) and asks for microphone access. It cannot
    hear anything until that permission is granted.
  EOS
end
