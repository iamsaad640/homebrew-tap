# Homebrew Tap

Homebrew casks for macOS apps by [Saad Ahmed](https://github.com/iamsaad640).

## Usage

Install an app directly; Homebrew adds the tap automatically:

```sh
brew install --cask iamsaad640/tap/<name>
```

Or add the tap once and use short names:

```sh
brew tap iamsaad640/tap
brew install --cask <name>
```

Update with `brew upgrade`, and remove with `brew uninstall --cask <name>`.

## Casks

| Cask | Description |
| --- | --- |
| [`lidless`](https://github.com/iamsaad640/lidless) | Menu bar toggle that keeps your Mac awake with the lid closed |

## Notes

These apps are ad-hoc signed rather than notarized by Apple. Each cask clears the download quarantine flag after installation so the app can launch. Read the cask in [`Casks/`](Casks) before installing if you want to review exactly what it does.

## License

[MIT](LICENSE)
