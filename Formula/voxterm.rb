class Voxterm < Formula
  desc "Voice HUD for AI CLIs with local Whisper STT"
  homepage "https://github.com/jguida941/voxterm"
  url "https://github.com/jguida941/voxterm/archive/refs/tags/v1.0.45.tar.gz"
  version "1.0.45"
  sha256 "1c520613e02cd6711b9cad130b91eaf85d412ab1922c438a5e9dd6561e524e68"

  depends_on "rust" => :build
  depends_on "cmake" => :build

  def install
    libexec.install Dir["*"]
    system "cargo", "build", "--release", "--bin", "voxterm", "--manifest-path", "#{libexec}/src/Cargo.toml"
    (bin/"voxterm").write <<~EOS
      #!/bin/bash
      export VOXTERM_CWD="$(pwd)"
      export VOXTERM_WRAPPER=1
      exec "#{libexec}/scripts/start.sh" "$@"
    EOS
    chmod 0755, bin/"voxterm"
  end

  def caveats
    <<~EOS
      First run downloads a Whisper model if missing.
      To pre-download manually:
        #{libexec}/scripts/setup.sh models --base

      Themes: chatgpt, claude, codex, coral, catppuccin, dracula, nord, tokyonight, gruvbox, ansi, none
      Backends: codex (default), claude, gemini (in works), or custom command

      Run `voxterm --help` for all options.
    EOS
  end
end
