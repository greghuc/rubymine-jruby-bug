#!/usr/bin/env bash

# Provision vagrant vm as normal vagrant user

JAVA_VERSION=13.0.1
JAVA_URL=https://download.java.net/java/GA/jdk13.0.1/cec27d702aa74d5a8630c65ae61e4305/9/GPL/openjdk-13.0.1_linux-x64_bin.tar.gz
RUBY_MRI=2.5.7
RUBY_JRUBY=jruby-9.2.9.0

BASH_FILE=$HOME/.bashrc
RBENV_ROOT=$HOME/.rbenv


# Specify directory where each user-*.sh can place scripts to be run on shell startup
export USER_STARTUP_SCRIPTS_DIR=$HOME/.startup-scripts
rm -rf ${USER_STARTUP_SCRIPTS_DIR}
mkdir -p ${USER_STARTUP_SCRIPTS_DIR}


####################################################################################

echo '** Setting up user-specific startup scripts dir **'

cat >> ${BASH_FILE} <<EOL
for sh_file in ${USER_STARTUP_SCRIPTS_DIR}/*.sh
do
    source \$sh_file
done
EOL

####################################################################################


####################################################################################

echo '** Installing java **'

rm -rf jdk-${JAVA_VERSION}
wget -qO- --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JAVA_URL} | tar xvz

####################################################################################


####################################################################################

echo '** Adding java to PATH **'

JAVA_DIR=$HOME/jdk-${JAVA_VERSION}

cat > ${USER_STARTUP_SCRIPTS_DIR}/java.sh <<EOL
export PATH=${JAVA_DIR}/bin:\$PATH
EOL

# Make sure it's on path, and tested for when installing jruby with ruby-build
source ${USER_STARTUP_SCRIPTS_DIR}/java.sh

####################################################################################



####################################################################################

echo '** Installing rbenv **'

rm -rf ${RBENV_ROOT}
git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT}

cat > ${USER_STARTUP_SCRIPTS_DIR}/rbenv.sh <<EOL
export PATH=$RBENV_ROOT/bin:\$PATH
eval "\$(rbenv init -)"
EOL

####################################################################################



####################################################################################

echo '** Installing ruby-build **'

git clone https://github.com/rbenv/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build

####################################################################################



####################################################################################

echo '** Installing rubies **'

source ${USER_STARTUP_SCRIPTS_DIR}/rbenv.sh
rbenv install ${RUBY_MRI}
rbenv install ${RUBY_JRUBY}

####################################################################################



echo -e "\n"
echo "========="
echo "== Box =="
echo "========="
echo "Processors: $(grep 'model name' /proc/cpuinfo | wc -l)"
echo "Memory:     $(grep MemTotal /proc/meminfo | sed -re 's/^MemTotal:\s+//g')"

echo -e "\n"
echo "========"
echo "== OS =="
echo "========"
echo "$(lsb_release -a)"

echo -e "\n"
echo "=========="
echo "== Java =="
echo "=========="
echo "$(java -version 2>&1)"

echo -e "\n"
echo "=========="
echo "== Ruby =="
echo "=========="
echo "$(rbenv versions)"
