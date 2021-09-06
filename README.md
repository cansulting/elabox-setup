# elabox-setup
The main repository for installing and building Elabox System

## Pre-built system installation ( Linux arm64 )
```
wget https://storage.googleapis.com/elabox/installer/linux/arm64/installer.sh
sudo chmod +x ./installer.sh
./installer.sh
```

## Building from source
make sure you did not install anything yet as it might fail the setup
```
git clone https://github.com/cansulting/elabox-system-tools.git
cd elabox-system-tools
cd ./scripts
sudo chmod +x setup.sh
./setup.sh
<Follow the SH instructions for other additional setups>
```
