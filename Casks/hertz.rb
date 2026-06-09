cask "hertz" do
  version "0.1.16"
  sha256 "11398b0e2cf1ce156f284af1c554fbff085b3aa2b0bcbaa21fa8750c4cb2ad43"

  url "https://github.com/pranshugupta54/hertz/releases/download/v#{version}/Hertz.app.zip"
  name "Hertz"
  desc "Native macOS menu-bar system monitor"
  homepage "https://github.com/pranshugupta54/hertz"

  # The app updates itself from GitHub Releases — Homebrew shouldn't manage it.
  auto_updates true
  depends_on macos: ">= :sonoma"

  # Install into the user's Applications so the in-app self-updater (which
  # rewrites its own bundle) needs no admin password.
  app "Hertz.app", target: "#{Dir.home}/Applications/Hertz.app"

  # Clear the download quarantine (ad-hoc signed, not notarized) so it opens
  # without a Gatekeeper prompt, then launch it into the menu bar.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine",
                          "#{Dir.home}/Applications/Hertz.app"],
                   sudo: false
    system_command "/usr/bin/open",
                   args: ["#{Dir.home}/Applications/Hertz.app"]
  end

  uninstall quit: "io.github.pranshugupta54.hertz"

  zap trash: "#{Dir.home}/Applications/Hertz.app"
end
