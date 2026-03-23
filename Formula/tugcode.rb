# Homebrew formula for tugcode
#
# This is the source copy. The canonical formula lives in:
#   https://github.com/tugtool/homebrew-tugtool
#
# To install:
#   brew tap tugtool/tugtool
#   brew install tugcode
#
# CI automatically updates the tap repo formula on each release.

class Tugcode < Formula
  desc "From ideas to implementation via multi-agent orchestration"
  homepage "https://github.com/tugtool/tugtool"
  version "0.7.43"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tugtool/tugtool/releases/download/v#{version}/tugcode-#{version}-macos-arm64.tar.gz"
      # SHA256 ARM64: 2337baf2dccbf330e5cfb6eba9535411f8c0609ffc3c757cc9a0c4ab5a4e0397
      sha256 "2337baf2dccbf330e5cfb6eba9535411f8c0609ffc3c757cc9a0c4ab5a4e0397"
    else
      url "https://github.com/tugtool/tugtool/releases/download/v#{version}/tugcode-#{version}-macos-x86_64.tar.gz"
      # SHA256 X86_64: 0ab92e6306e9e1d389d77692a915c1334a02ddd4bd48ebb55701ba6da2fe33ee
      sha256 "0ab92e6306e9e1d389d77692a915c1334a02ddd4bd48ebb55701ba6da2fe33ee"
    end
  end

  def install
    bin.install "bin/tugcode"
    bin.install "bin/tugbank"

    # Install skills to share directory
    # Skills end up at #{HOMEBREW_PREFIX}/share/tugplug/skills/
    (share/"tugplug").install "share/tugplug/skills"

    # Install agents to share directory
    # Agents end up at #{HOMEBREW_PREFIX}/share/tugplug/agents/
    (share/"tugplug").install "share/tugplug/agents"
  end

  def caveats
    <<~EOS
      Tugcode agents have been installed to:
        #{HOMEBREW_PREFIX}/share/tugplug/agents/

      Claude Code skills have been installed to:
        #{HOMEBREW_PREFIX}/share/tugplug/skills/

      To use the plugin with Claude Code:
        cd /path/to/your-project
        claude --plugin-dir #{HOMEBREW_PREFIX}/share/tugplug

      Then use the skills:
        /tugplug:plan "your idea"
        /tugplug:implement .tugtool/tugplan-N.md
        /tugplug:merge .tugtool/tugplan-N.md
    EOS
  end

  test do
    system "#{bin}/tugcode", "--version"
  end
end
