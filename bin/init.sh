#!/bin/sh

set -eux

sudo docker compose exec app-zotprime-dataserver sh -cux 'cd /var/www/zotero/misc && ./init-mysql.sh'
#sudo docker compose exec app-zotprime-dataserver sh -cux 'cd /var/www/zotero/misc && ./db_update.sh'
#sudo docker compose exec app-zotprime-dataserver sh -cux 'cd /var/www/zotero/misc/db-updates/2021-10-16 && php ./0_addMasterGroupHasData'
#sudo docker compose exec app-zotprime-dataserver sh -cux 'cd /var/www/zotero/misc/db-updates/2021-10-16 && php ./1_removeMasterGroupTimestampAndVersion'
sudo docker compose exec app-zotprime-dataserver sh -cux 'aws --endpoint-url "http://minio:9000" s3 mb s3://zotero'
sudo docker compose exec app-zotprime-dataserver sh -cux 'aws --endpoint-url "http://minio:9000" s3 mb s3://zotero-fulltext'
sudo docker compose exec app-zotprime-dataserver sh -cux 'aws --endpoint-url "http://localstack:4575" sns create-topic --name zotero'