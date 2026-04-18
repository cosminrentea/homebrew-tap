class Caffeinated < Formula
  desc "Prevent macOS sleep while specific processes are running"
  homepage "https://github.com/cosminrentea/caffeinated"
  url "https://github.com/cosminrentea/caffeinated/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d240f15ea528c3a0c2fc4dc13c255cdfbd048e30e8494d0b5a850152cd632464"
  license "MIT"

  def install
    bin.install "bin/caffeinated"
    (share/"caffeinated").install "share/caffeinated/watch.conf.example"
    (share/"caffeinated").install "share/caffeinated/com.caffeinated.plist"
  end

  def post_install
    (var/"log/caffeinated").mkpath
    conf_dir = Pathname.new("#{Dir.home}/.config/caffeinated")
    conf_dir.mkpath
    conf_file = conf_dir/"watch.conf"
    unless conf_file.exist?
      cp share/"caffeinated/watch.conf.example", conf_file
    end
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
