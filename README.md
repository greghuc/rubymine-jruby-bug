# README

This project shows that Rubymine 2018.1 + vagrant + JRuby 9.2.0 + Java 10.0.1 doesn't work. To demonstrate this,
follow the instructions below. We first create a vagrant box with java 10.0.1, jruby 9.2.0 and ruby 1.5.3 installed.
We then configure Rubymine 2018.1 to use either installed Ruby as a remote interpreter: ruby 1.5.3 works fine, but jruby 9.2.0
does not.

Observed error messages when setting jruby as a remote interpreter:
* Rubymine shows error modal: "Can't create Ruby SDK, Could not find gems binaries directory"
* Rubymine log also says "No `java' executable found on PATH" (when there is)

## Creating a vagrant box

```
# Install VirtualBox and Vagrant
# VirtualBox: https://www.virtualbox.org/wiki/Downloads
# Vagrant: http://downloads.vagrantup.com

git clone https://github.com/greghuc/rubymine-jruby-bug.git

cd rubymine-jruby-bug

vagrant up

vagrant ssh

cd /vagrant

# check java is installed
java --version

# check jruby is installed
ls /home/vagrant/.rbenv/versions/jruby-9.2.0.0/bin/ruby

# check ruby is installed
ls /home/vagrant/.rbenv/versions/2.5.0/bin/ruby
```

## Configuring Rubymine

```
Rubymine 2018.1

Build, Execution, Deployment
- Deployment
  - Add server
    - Name: Vagrant server
    - Type: SFTP
    - Connection
    	- SFTP host: 127.0.0.1
    	- Port: 2222
    	- Root path: /
    	- User name: vagrant
    	- Password: vagrant (+save password)
    - Mappings
      - Local path: enter local folder of https://github.com/greghuc/rubymine-jruby-bug
      - Deployment path: /vagrant

For Ruby 2.5.0

Languages & Frameworks
- Ruby SDK and Gems
  - New remote
    - Select "Vagrant"
    - Ruby interpreter path: /home/vagrant/.rbenv/versions/2.5.0/bin/ruby
=> works correctly, loading all gems

For JRuby 9.2.0

Languages & Frameworks
- Ruby SDK and Gems
  - New remote
    - Select "Vagrant"
    - Ruby interpreter path: /home/vagrant/.rbenv/versions/jruby-9.2.0.0/bin/ruby
 => Shows error modal: "Can't create Ruby SDK, Could not find gems binaries directory"
 => Log also says "No `java' executable found on PATH" (when there is)
```

## Logs

Rubymine 2018.1 log whilst setting JRuby as a remove interpreter:

```
2018-07-13 11:10:46,766 [ 120778]   INFO -    #com.intellij.ssh.RSyncUtil - rsync version: rsync  version 2.6.9  protocol version 29 
2018-07-13 11:10:47,435 [ 121447]   INFO - ellij.ssh.SshConnectionService - Creating sftp channel within SSH session @62eb402b to vagrant@127.0.0.1:2200 
2018-07-13 11:10:47,454 [ 121466]   INFO - ellij.ssh.SshConnectionService - Creating sftp channel within SSH session @62eb402b to vagrant@127.0.0.1:2200 
2018-07-13 11:10:47,470 [ 121482]   INFO - ellij.ssh.SshConnectionService - Executing SSH command: env "JETBRAINS_REMOTE_RUN"="1" "ANSICON"="" "LANG"="en_GB.UTF-8" "RM_INFO"="RM-181.4203.562" /home/vagrant/.rbenv/versions/jruby-9.2.0.0/bin/ruby -e "puts RUBY_DESCRIPTION.strip; puts RUBY_PATCHLEVEL.to_s" within SSH session @62eb402b to vagrant@127.0.0.1:2200 
2018-07-13 11:10:47,484 [ 121496]   INFO - mote.RubyRemoteSdkConfigurator - initializing Remote: ruby-No `java' executable found on PATH.: No `java' executable found on PATH. (vagrant:///Users/greghuc/workspace/rubymine-jruby-bug/home/vagrant/.rbenv/versions/jruby-9.2.0.0/bin/ruby) 
2018-07-13 11:10:47,486 [ 121498]   INFO - ellij.ssh.SshConnectionService - Creating sftp channel within SSH session @62eb402b to vagrant@127.0.0.1:2200 
2018-07-13 11:10:47,499 [ 121511]   INFO - ellij.ssh.SshConnectionService - Executing SSH command: cd /home/vagrant/.rbenv/versions/jruby-9.2.0.0/bin; env "JETBRAINS_REMOTE_RUN"="1" "ANSICON"="" "LANG"="en_GB.UTF-8" "PATH"="/home/vagrant/.rbenv/versions/jruby-9.2.0.0/bin:$PATH" "RM_INFO"="RM-181.4203.562" /home/vagrant/.rbenv/versions/jruby-9.2.0.0/bin/ruby -x /home/vagrant/.rbenv/versions/jruby-9.2.0.0/bin/gem environment within SSH session @62eb402b to vagrant@127.0.0.1:2200
```


