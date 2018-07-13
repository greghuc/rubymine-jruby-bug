#!/usr/bin/env bash

# Provision vagrant vm as normal vagrant user

# Specify directory where each user-*.sh can place scripts to be run on shell startup
export USER_STARTUP_SCRIPTS_DIR=$HOME/.startup-scripts
rm -rf ${USER_STARTUP_SCRIPTS_DIR}
mkdir -p ${USER_STARTUP_SCRIPTS_DIR}

source /vagrant/vagrant/user-java.sh
source /vagrant/vagrant/user-ruby.sh
source /vagrant/vagrant/user-versions.sh