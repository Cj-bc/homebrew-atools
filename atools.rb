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
  

  def install
    system "./install.sh", prefix
    bash_completion.install "lib/atools.completion"
  end

  def caveats
    "ATools"
  end
end
