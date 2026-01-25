class CodexVoice < Formula
  desc "Voice-enabled overlay for Codex CLI"
  homepage "https://github.com/jguida941/codex-voice"
  url "https://github.com/jguida941/codex-voice/archive/refs/tags/v1.0.4.tar.gz"
  version "1.0.4"
  sha256 "707be283c1e4137df74c78ed6dd8506fe03f5c7cf40aecdb956bcfd4dced15ae"

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
