#!/usr/bin/env bash

set -ex

echo "CREATE DATABASE \`c5\` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" | mysql -u root;\
echo "GRANT ALL PRIVILEGES ON c5.* TO c5@\"localhost\" IDENTIFIED BY \"$(curl http://169.254.169.254/latest/meta-data/instance-id)\";" | mysql -u root
mysqladmin -u root password $(curl http://169.254.169.254/latest/meta-data/instance-id)

php /var/www/concrete5/cli/install-concrete5.php \
--db-server=localhost \
--db-username=c5 \
--db-password="$(curl http://169.254.169.254/latest/meta-data/instance-id)" \
--db-database=c5 \
--admin-email=c5@example.com \
--admin-password="$(curl http://169.254.169.254/latest/meta-data/instance-id)" \
--reinstall=yes
