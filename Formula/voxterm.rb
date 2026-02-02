class Voxterm < Formula
  desc "Voice HUD for AI CLIs with local Whisper STT"
  homepage "https://github.com/jguida941/voxterm"
  url "https://github.com/jguida941/voxterm/archive/refs/tags/v1.0.31.tar.gz"
  version "1.0.31"
  sha256 "39759140058896090b945a976a2d951230d44d20270e5c20648bfab0dc5bd4b9"

  depends_on "rust" => :build
  depends_on "cmake" => :build

  def install
    libexec.install Dir["*"]
    system "cargo", "build", "--release", "--bin", "voxterm", "--manifest-path", "#{libexec}/rust_tui/Cargo.toml"
    (bin/"voxterm").write <<~EOS
      #!/bin/bash
      export VOXTERM_CWD="$(pwd)"
      export VOXTERM_WRAPPER=1
      exec "#{libexec}/start.sh" "$@"
    EOS
    chmod 0755, bin/"voxterm"
  end

  def caveats
    <<~EOS
      First run downloads a Whisper model if missing.
      To pre-download manually:
        #{libexec}/scripts/setup.sh models --base

      Themes: coral, catppuccin, dracula, nord, ansi, none
      Backends: codex (default), claude, gemini, aider, opencode, or custom command

      Run `voxterm --help` for all options.
    EOS
  end
end
