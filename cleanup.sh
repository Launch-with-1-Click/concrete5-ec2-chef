#!/usr/env/bin bash

set -ex

echo "Yes? or Ctrl+C"
read hoge

apt-get clean all

chef-server-ctl stop
chef-server-ctl cleanse
rm -rf /root/chef-server-cleanse-*
sudo install -d /etc/chef-server
sudo install -o root -g root -m 0640 /vagrant/files/chef-server.rb /etc/chef-server/


rm -rf /tmp/*
rm -rf /vagrant
rm -f /etc/ssh/ssh_host_*
cd /var/log
find /var/log/ -type f -name '*.log' -exec cp /dev/null {} \;
cp /dev/null /var/log/syslog


yes | cp /dev/null /root/.ssh/authorized_keys
yes | cp /dev/null /root/.bash_history
if [ -d /home/ubuntu ]; then
  yes | cp /dev/null /home/ubuntu/.ssh/authorized_keys
  yes | cp /dev/null /home/ubuntu/.bash_history
fi
history -c

