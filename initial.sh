echo 'y' |  mkfs.ext4 /dev/sda
mount /dev/sda /home/elabox/
# check the unique identifier of /dev/sda
USD_UUID=$(sudo blkid | grep /dev/sda | cut -d '"' -f 2)
# update the /etc/fstab file to auto-mount the disk on startup
echo "UUID=${USD_UUID} /home/elabox/ ext4 defaults 0 0" | tee -a /etc/fstab > /dev/null

chown -R elabox:elabox /home/elabox/

sudo -u elabox /var/tmp/ela.sh

cd /home/elabox/elabox-companion
rm -rf /var/www/elabox 
mkdir /var/www/elabox
cp -R build /var/www/elabox/build
/etc/init.d/nginx restart
/etc/init.d/avahi-daemon restart


cp /home/elabox/elabox-master/default /etc/nginx/sites-available/default

cd;
cd /home/elabox/elabox-master
env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u elabox --hp /home/elabox