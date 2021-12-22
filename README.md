# elabox-setup
The main repository for installing and building Elabox System

## Pre-built system installer ( Linux arm64 )
```
wget https://github.com/cansulting/elabox-setup/releases/download/build3/installer_linux_arm64_installer.sh
sudo chmod +x ./installer_linux_arm64_installer.sh
./installer_linux_arm64_installer.sh
```

## Building from source
make sure you did not install anything yet as it might fail the setup
```
git clone https://github.com/cansulting/elabox-system-tools.git
cd elabox-system-tools
cd internal/scripts
sudo chmod +x setup.sh
sudo ./setup.sh
<Follow the SH instructions for other additional setups>
```
