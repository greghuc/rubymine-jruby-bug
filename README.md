# README

This project shows that Rubymine 2019.3 + vagrant + JRuby 9.2.9 + Java 13.0.1 doesn't work. To demonstrate this,
follow the instructions below. We first create a vagrant box with java 13.0.1, jruby 9.2.9 and ruby 2.5.7 installed.
We then configure Rubymine 2019.3 to use either installed Ruby as a remote interpreter: ruby 2.5.3 works fine, but jruby 9.2.9
does not.

Observed error messages when setting jruby as a remote interpreter:
* Rubymine shows error modal: "Unable to read RBConfig from specified interpreter"
* Rubymine log also says "No `java' executable found on PATH." (when there is)

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

# check ruby is installed
ls /home/vagrant/.rbenv/versions/2.5.7/bin/ruby

# check java is installed
java --version

# check jruby is installed
ls /home/vagrant/.rbenv/versions/jruby-9.2.9.0/bin/ruby
```

## Configuring Rubymine

```
Rubymine 2019.3

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

For Ruby 2.5.7

Languages & Frameworks
- Ruby SDK and Gems
  - New remote
    - Select "Vagrant"
    - Ruby interpreter path: /home/vagrant/.rbenv/versions/2.5.7/bin/ruby
=> works correctly, loading all gems

For JRuby 9.2.9

Languages & Frameworks
- Ruby SDK and Gems
  - New remote
    - Select "Vagrant"
    - Ruby interpreter path: /home/vagrant/.rbenv/versions/jruby-9.2.9.0/bin/ruby
 => Shows error modal: "Unable to read RBConfig from specified interpreter"
 => Log also says "No `java' executable found on PATH" (when there is)
```

## Logs

Rubymine 2019.3 log whilst setting JRuby as a remote interpreter:

```
2019-12-05 10:45:12,593 [ 124997]   WARN - plugins.ruby.ruby.sdk.RbConfig - Error getting RbConfig from /home/vagrant/.rbenv/versions/jruby-9.2.9.0/bin/ruby, error code 255; STDOUT: No `java' executable found on PATH.; STDERR:  
```


