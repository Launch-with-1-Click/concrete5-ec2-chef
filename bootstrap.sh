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

mkdir -p /etc/chef/ohai/hints
echo '{}' > /etc/chef/ohai/hints/ec2.json

mkdir /var/chef
cd /var/chef/
/usr/bin/git clone https://github.com/Launch-with-1-Click/concrete5-ec2-chef.git .
/usr/bin/gem install bundler
/usr/local/bin/bundle install
/usr/bin/gem update
/usr/local/bin/berks install --path cookbooks

sudo install -o root -g root -m 0700 /vagrant/files/concrete5.cron /etc/cron.d/concrete5
