class CodexVoice < Formula
  desc "Voice-enabled overlay for Codex CLI"
  homepage "https://github.com/jguida941/codex-voice"
  url "https://github.com/jguida941/codex-voice/archive/refs/tags/v1.0.3.tar.gz"
  version "1.0.3"
  sha256 "517403bd5ed9f574be85b7b897beee6da2411f3e9f1700917af08925ce918e46"

  depends_on "rust" => :build
  depends_on "cmake" => :build

  def install
    libexec.install Dir["*"]
    system "cargo", "build", "--release", "--bin", "codex_overlay", "--manifest-path", "#{libexec}/rust_tui/Cargo.toml"

    bin.install "#{libexec}/rust_tui/target/release/codex_overlay" => "codex-overlay"
    (bin/"codex-voice").write <<~EOS
      #!/bin/bash
      export CODEX_VOICE_CWD="$(pwd)"
      exec "#{libexec}/start.sh" "$@"
    EOS
    chmod 0755, bin/"codex-voice"
  end

  def caveats
    <<~EOS
      First run downloads a Whisper model if missing.
      To pre-download manually:
        #{libexec}/scripts/setup.sh models --base
    EOS
  end
end
