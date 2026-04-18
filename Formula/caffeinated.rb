class Caffeinated < Formula
  desc "Prevent macOS sleep while specific processes are running"
  homepage "https://github.com/cosminrentea/caffeinated"
  url "https://github.com/cosminrentea/caffeinated/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "dcb6e3e2dd372cfe75387d23f57ded4a0086136f6c291230c31a24183f077d08"
  license "MIT"

  def install
    bin.install "bin/caffeinated"
    (share/"caffeinated").install "share/caffeinated/watch.conf.example"
    (share/"caffeinated").install "share/caffeinated/com.caffeinated.plist"
  end

  def caveats
    <<~EOS
      To start caffeinated as a background service (starts at login, restarts on crash):

        brew services start caffeinated

      Then edit your watch list:

        #{Dir.home}/.config/caffeinated/watch.conf

      Add one process name per line. Check status with:

        caffeinated --status
    EOS
  end

  service do
    run [opt_bin/"caffeinated"]
    keep_alive true
    log_path var/"log/caffeinated/caffeinated.log"
    error_log_path var/"log/caffeinated/caffeinated.log"
  end

  test do
    assert_match "caffeinated", shell_output("#{bin}/caffeinated --help")
  end
end
