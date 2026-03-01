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
  version "0.7.25"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tugtool/tugtool/releases/download/v#{version}/tugcode-#{version}-macos-arm64.tar.gz"
      # SHA256 ARM64: 831881adf25790497ab67116abee453ae0e32e6aac12fb820df96295eca45fa7
      sha256 "831881adf25790497ab67116abee453ae0e32e6aac12fb820df96295eca45fa7"
    else
      url "https://github.com/tugtool/tugtool/releases/download/v#{version}/tugcode-#{version}-macos-x86_64.tar.gz"
      # SHA256 X86_64: dd13deb543b8865a380ac958a97aaa19e861baa465ec3165bc51cb4fc323e55a
      sha256 "dd13deb543b8865a380ac958a97aaa19e861baa465ec3165bc51cb4fc323e55a"
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
