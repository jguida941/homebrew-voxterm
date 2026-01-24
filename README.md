# homebrew-codex-voice

Homebrew tap for Codex Voice (Rust overlay mode).

## Install

```bash
brew tap jguida941/homebrew-codex-voice
brew install codex-voice
```

## Run from any project (first run downloads model if missing)

```bash
cd ~/my-project
codex-voice
```

## Optional model pre-download

```bash
$(brew --prefix)/opt/codex-voice/libexec/scripts/setup.sh models --base
```

## Notes

- This formula builds from source (Rust + CMake required).
- The formula is pinned to the `v1.0.2` release. Update the `url` and `sha256`
  when you cut a new tag.
