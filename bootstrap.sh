#!/usr/bin/env bash

set -ex

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales
apt-get update -y
apt-get upgrade -y
apt-get install -y git ruby1.9.3 libxslt-dev libxml2-dev make
curl -L https://www.opscode.com/chef/install.sh | bash

mkdir /var/chef
cd /var/chef/
git clone https://github.com/Launch-with-1-Click/concrete5-ec2-chef.git .
gem install bundler
/usr/local/bin/bundle install
/usr/bin/gem update
mkdir -p /etc/chef/ohai/hints
echo '{}' > /etc/chef/ohai/hints/ec2.json
/usr/local/bin/berks install --path cookbooks

