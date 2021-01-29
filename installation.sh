sudo useradd -p $(openssl passwd -1 elabox) -m elabox
sudo usermod -aG sudo elabox
sudo -s -u elabox

echo 'elabox' | curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
echo 'Y' | sudo apt update && sudo apt install fail2ban avahi-daemon tar nodejs make build-essential tor nginx zip
sudo npm_config_user=root npm install -g onoff
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

sudo apt-get install chromium-browser
sudo npm install -g pm2


sudo mkdir -v /var/cache/swap
cd /var/cache/swap
sudo dd if=/dev/zero of=swapfile bs=1K count=4M
sudo chmod 600 swapfile
sudo mkswap swapfile
sudo swapon swapfile

top -bn1 | grep -i swap




##############################
# Configure ufw
##############################

# open the different ports with ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
# SSH port
sudo ufw allow 22
# companiont app port
sudo ufw allow 80
# elabox back-end port
sudo ufw allow 3001
sudo ufw allow 3002
# ELA DPoS port
sudo ufw allow 20339
# ELA port for SPV peers
sudo ufw allow 20338
# ELA RPC port
sudo ufw allow 20336
# ELA REST port
sudo ufw allow 20334
# DID REST port
sudo ufw allow 20604
# DID RPC port
sudo ufw allow 20606
# DID node port
sudo ufw allow 20608
echo 'y' | sudo ufw enable


##############################
# Configure TOR
##############################

# add the webserver and SSH to tor
echo ""  | sudo tee -a /etc/tor/torrc
echo "HiddenServiceDir /var/lib/tor/elabox/"  | sudo tee -a /etc/tor/torrc
echo "HiddenServicePort 80 127.0.0.1:80" | sudo tee -a /etc/tor/torrc
echo "HiddenServicePort 22 127.0.0.1:22" | sudo tee -a /etc/tor/torrc
echo "HiddenServicePort 3001 127.0.0.1:3001" | sudo tee -a /etc/tor/torrc
echo ""  | sudo tee -a /etc/tor/torrc
sudo systemctl restart tor@default


##############################
# Configure hostname
##############################

# Update hostname to elabox
echo "Updating hostname..."
echo "elabox" | sudo tee /etc/hostname
echo "127.0.0.1 elabox" | sudo tee /etc/hosts
sudo hostnamectl set-hostname elabox
# hostnamectl to check
/etc/init.d/avahi-daemon restart
systemctl restart systemd-logind.service