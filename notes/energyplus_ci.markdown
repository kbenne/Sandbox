---
layout: post
title: EnergyPlus Continous Integration
---

EnergyPlus continuous integration is based on [Decent CI](https://github.com/lefticus/decent_ci). This is how I have it setup on Mac OS X. I am using luanchd to initiate the process on system startup with a watch dog to keep the process alive. Launchd is very good at keeping the process running if it fails for any reason.

Create a file /Library/Scripts/run_ci.rb with this content:

{% highlight ruby %}
#!/usr/bin/env ruby

require 'fileutils'

if ARGV.length < 4
  puts "Usage: #{__FILE__} <buildfolder> <testruntrueorfalse> <githubtoken> <repositoryname> (<repositoryname> ...)"
  abort("Not enough arguments")
end

sleep(30)

FileUtils.mkdir_p(ARGV[0])
FileUtils.cd(ARGV[0])

system("git clone https://github.com/lefticus/decent_ci")

while true
  puts "Updating decent_ci"
  system("cd decent_ci && git pull")
  puts "Running ci.rb"
  ci_args = ARGV[1..-1]
  system("#{RbConfig.ruby}", "decent_ci/ci.rb", *ci_args)
  puts "Sleeping"

  sleep(300)
end
{% endhighlight %}


Create another file /Library/LaunchDaemons/com.nrel.ci.plist with this content, replacing JohnDoe with your user info, and aws id and key with your credentials:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC -//Apple Computer//DTD PLIST 1.0//EN http://www.apple.com/DTDs/PropertyList-1.0.dtd >
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.nrel.ci</string>
	<key>ProgramArguments</key>
	<array>
		<string>/System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/bin/ruby</string>
		<string>/Library/Scripts/run_ci.rb</string>
		<string>ci_runs</string>
		<string>--aws-access-key-id=***id***</string>
		<string>--aws-secret-access-key=***secret-key***</string>
		<string>false</string>
		<string>***github token***</string>
		<string>NREL/EnergyPlus</string>
	</array>
	<key>KeepAlive</key>
	<true/>
	<key>UserName</key>
	<string>JohnDoe</string>
	<key>StandardOutPath</key>
	<string>/var/log/ci.log</string>
	<key>StandardErrorPath</key>
	<string>/var/log/ci.log</string>
	<key>WorkingDirectory</key>
	<string>/Users/JohnDoe</string>
</dict>
</plist>
{% endhighlight %}

