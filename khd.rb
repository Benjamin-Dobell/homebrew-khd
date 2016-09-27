class Khd < Formula
  desc "Simple hotkey-daemon for OSX."
  homepage "https://github.com/koekeishiya/khd"
  url "https://github.com/koekeishiya/khd/releases/download/v1.0.0/Khd-1.0.0.zip"
  sha256 "dca4061427b90e25417cf752fc752f91d9dfd6b8aff003ef2214ccb9ed013205"

  def install
    bin.install "khd"
    prefix.install %w[khdrc]
  end

  plist_options :startup => false

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
      <string>/usr/local/bin/khd</string>
      </array>
      <key>KeepAlive</key>
      <true/>
      <key>StandardOutPath</key>
      <string>/tmp/khd.out</string>
      <key>StandardErrorPath</key>
      <string>/tmp/khd.err</string>
      <key>Sockets</key>
      <dict>
        <key>Listeners</key>
        <dict>
          <key>SockServiceName</key>
          <string>3021</string>
          <key>SockType</key>
          <string>dgram</string>
          <key>SockFamily</key>
          <string>IPv4</string>
      </dict>
    </dict>
    </dict>
    </plist>
    EOS
  end

  def caveats; <<-EOS.undent
    Copy the example config from #{prefix}/khdrc into your home directory.
      cp #{prefix}/khdrc ~/.khdrc
    EOS
  end

  test do
    system "/usr/local/bin/khd", "--version"
  end
end
