#!/usr/bin/env bash

# Setup ruby
# NOTE: Assumes existence of USER_STARTUP_SCRIPTS_DIR variable

# Configurable variables
RUBY_MRI=2.5.0
RUBY_JRUBY=jruby-9.2.0.0
STACK_SIZE=256k
HEAP_SIZE=700m

# 'Global' variables in this file
RBENV_ROOT=$HOME/.rbenv


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