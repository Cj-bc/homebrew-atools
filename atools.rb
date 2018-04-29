require "formula"

class Atools < Formula
  homepage "https://github.com/coord-e/atools"
  version 'v1.0.0'

  url "https://github.com/coord-e/atools/archive/" + version + ".tar.gz"
  sha256 "0e0bcd378d8c8bf1ecc8c92fc398c9e61ebb38804ce6b8a1623c2f75a78f0c57"

  depends_on "bash-completion@2"

  depends_on "w3m" if OS.mac?
  depends_on "tmux" => :optional
  depends_on "fzf" => :optional 
  depends_on "peco" => :optional
  

  def depcheck
    # 1. check Bash version
    # 2. check all dependencies
    #   2-1. output error message
    odie "you need bash 4.0 or higher" unless `bash --version`.split(" ")[3][0].to_i >= 4
    dependencies = ["w3m", "curl", "xmllint", "jq"]
    ENV.store('PATH', ENV.fetch('PATH').to_s + ":" + prefix + "/bin/")
    for dep in dependencies do
      odie "you need #{dep}. please install." unless system "type", dep
    end

  end

  def install
    # 1. check dependencies
    # 2. install all scripts in bin/
    depcheck
    for executable in Dir.entries('bin') do
      next if executable.start_with?('.')
      bin.install executable
    end
    bash_completion.install "lib/atools.completion"
  end

  def caveats;<<~EOT
    To activate bash-completion for atools, you need to do:
      restart your terminal
    or
      $ source ~/.bash_profile
    EOT
  end

end
