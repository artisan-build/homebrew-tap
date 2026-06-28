# Ballast Homebrew Tap

Homebrew tap for the [Ballast CLI](https://github.com/artisan-build/ballast-cli) — a
local-first durability-scoring CLI.

## Install

```
brew install artisan-build/tap/ballast
```

(Equivalently: `brew tap artisan-build/tap && brew install ballast`.)

## Upgrade

```
brew upgrade ballast
```

## About

This tap distributes the **signed + notarized macOS binary** (per-arch: Apple Silicon and
Intel). `Formula/ballast.rb` is **auto-generated** and pushed here by the ballast-cli release
pipeline on each tagged `v*` release, so it always points at the latest published version.
