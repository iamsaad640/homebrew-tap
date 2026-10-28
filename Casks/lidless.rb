cask "lidless" do
  version "1.0.0"
  sha256 "83d23660423029d2789b7cb97356059bdba98e861ac2b09c964587e0081719c6"

  url "https://github.com/iamsaad640/lidless/releases/download/v#{version}/Lidless-#{version}.zip"
  name "Lidless"
  desc "Menu bar toggle that keeps the computer awake with the lid closed"
  homepage "https://github.com/iamsaad640/lidless"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "Lidless.app"

  # The app is ad-hoc signed, not notarized, so Gatekeeper blocks it while quarantined.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-d", "-r", "com.apple.quarantine", "#{appdir}/Lidless.app"]
  end

  uninstall quit:       "io.github.iamsaad640.lidless",
            login_item: "Lidless",
            script:     {
              executable:   "/usr/bin/sudo",
              args:         ["-n", "/usr/bin/pmset", "disablesleep", "0"],
              must_succeed: false,
            }

  zap trash:  "~/Library/Preferences/io.github.iamsaad640.lidless.plist",
      delete: "/etc/sudoers.d/lidless"

  caveats <<~EOS
    Lidless switches sleep with `sudo -n pmset disablesleep`, which needs a
    one-time sudo rule:

      echo "$(id -un) ALL=(root) NOPASSWD: /usr/bin/pmset disablesleep 0, /usr/bin/pmset disablesleep 1" > /tmp/lidless.sudoers
      sudo visudo -cf /tmp/lidless.sudoers && sudo install -m 0440 -o root -g wheel /tmp/lidless.sudoers /etc/sudoers.d/lidless

    Uninstalling turns sleep back on. `brew uninstall --zap` also removes the rule.
  EOS
end
