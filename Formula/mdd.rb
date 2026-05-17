class Mdd < Formula
  desc "Structural queries on Markdown files for coding agents"
  homepage "https://github.com/cosminrentea/mdd"
  url "https://github.com/cosminrentea/mdd/releases/download/v0.2.0/mdd-0.2.0-aarch64-apple-darwin.tar.gz"
  sha256 "b0e416efc2d3e57b9d8b1c3e72c56320f4b1a563437193cba766cc8893254238"
  license "MIT"
  version "0.2.0"

  def install
    bin.install "mdd"
  end

  test do
    system "#{bin}/mdd", "--version"
  end
end
