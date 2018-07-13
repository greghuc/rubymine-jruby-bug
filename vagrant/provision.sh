#!/usr/bin/env bash


# Provision vagrant vm as root user

####################################################################################

## Update packages and install essentials

# Get latest package listings, post adding new repos
apt-get -y update

# Considered a sane build environment, by: https://github.com/sstephenson/ruby-build/wiki
apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev

# Useful to have
apt-get install -y git curl

####################################################################################


####################################################################################

## Tidy up

# Remove packages that are no longer needed
apt-get autoremove -y

# Remove local package files, to keep size down
apt-get clean

####################################################################################


####################################################################################

## Run user-level config
su -c 'source /vagrant/vagrant/user-config.sh' vagrant

####################################################################################