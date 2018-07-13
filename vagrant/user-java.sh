#!/usr/bin/env bash

# Setup ruby
# NOTE: Assumes existence of USER_STARTUP_SCRIPTS_DIR variable

JAVA_10_VERSION=10.0.1
JAVA_10_URL=http://download.oracle.com/otn-pub/java/jdk/${JAVA_10_VERSION}+10/fb4372174a714e6b8c52526dc134031e/jdk-${JAVA_10_VERSION}_linux-x64_bin.tar.gz


####################################################################################

echo '** Installing java **'

rm -rf jdk-${JAVA_10_VERSION}
wget -qO- --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JAVA_10_URL} | tar xvz

####################################################################################


####################################################################################

echo '** Adding java to PATH **'

cat > ${USER_STARTUP_SCRIPTS_DIR}/java.sh <<EOL
export PATH=${JAVA_DIR}/bin:\$PATH
EOL

# Make sure it's on path, and tested for when installing jruby with ruby-build
source ${USER_STARTUP_SCRIPTS_DIR}/java.sh


####################################################################################