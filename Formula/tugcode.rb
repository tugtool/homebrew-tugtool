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
  version "0.6.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tugtool/tugtool/releases/download/v#{version}/tugcode-#{version}-macos-arm64.tar.gz"
      # SHA256 ARM64: 9588c83b356e3fda3ed7e7bc2eb8683feeaa9037abf4bd849657f8dea782ef95
      sha256 "9588c83b356e3fda3ed7e7bc2eb8683feeaa9037abf4bd849657f8dea782ef95"
    else
      url "https://github.com/tugtool/tugtool/releases/download/v#{version}/tugcode-#{version}-macos-x86_64.tar.gz"
      # SHA256 X86_64: 62a65f61cd8525b7f5c7a3aedb1bdce3857cee91b4c12795fa66750e761c8c79
      sha256 "62a65f61cd8525b7f5c7a3aedb1bdce3857cee91b4c12795fa66750e761c8c79"
    end
  end

  def install
    bin.install "bin/tugcode"

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
