class Khd < Formula
  desc "Simple hotkey-daemon for OSX."
  homepage "https://github.com/koekeishiya/khd"
  url "https://github.com/koekeishiya/khd/releases/download/v1.1.0/Khd-1.1.0.zip"
  sha256 "b38f7725d4a644ba4d5250d20265ebfdd7b10184473882eefac2e9d01de8648f"

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
      <string>#{bin}/khd</string>
      </array>
      <key>EnvironmentVariables</key>
      <dict>
        <key>PATH</key>
        <string>#{bin}</string>
      </dict>
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
    system "#{bin}/khd", "--version"
  end
end
