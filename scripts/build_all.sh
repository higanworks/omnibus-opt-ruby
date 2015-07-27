#!/usr/bin/env bash

set -e
RUBYPATH="/opt/rubies/ruby-2.1.5/bin"
BUILD_ITERATION=${CIRCLE_BUILD_NUM:-1}

if [ ! "$RETRY" == "true" ] ; then
  bundle exec kitchen destroy
fi
# bundle exec kitchen converge -c 4

# for plat in ubuntu ; do
for plat in centos-6 ubuntu ; do
  bundle exec kitchen converge ${plat}
  bundle exec kitchen exec ${plat} -c "sudo ${RUBYPATH}/gem install bundler --no-ri --no-rdoc"
  bundle exec kitchen exec ${plat} -c "sudo chmod 0777 /opt"
  bundle exec kitchen exec ${plat} -c "export PATH=${RUBYPATH}:\$PATH; export BUNDLE_APP_CONFIG=bundle_${plat} ;cd /home/vagrant/opt-ruby; bundle install --jobs=2 --verbose --binstubs bin_${plat} --without development --path=vendor/bundle_${plat}"
  bundle exec kitchen exec ${plat} -c "export PATH=${RUBYPATH}:\$PATH; export HOME=/home/vagrant ; export BUNDLE_APP_CONFIG=bundle_${plat} ;export BUILD_ITERATION=${BUILD_ITERATION} ;cd /home/vagrant/opt-ruby; ./bin/omnibus build opt-ruby"
done
