##############################
# Define parameters
##############################

# define parameters
ELABOX_HOME=/home/elabox
BINARY_DIR=/home/elabox/elabox-binaries/binaries
SCRIPTS_DIR=/home/elabox/elabox-binaries


##############################
# Configure elabox-binaries
##############################

# clone the elabox-binaries repo
cd;
git clone https://elaboxx:elabox_2020@github.com/cansulting/elabox-binaries
# 2 - create supernode and elabox directories
mkdir ${ELABOX_HOME}/supernode
mkdir ${ELABOX_HOME}/supernode/did
mkdir ${ELABOX_HOME}/supernode/ela
mkdir ${ELABOX_HOME}/supernode/carrier

# get ela binary and config file
cp ${BINARY_DIR}/ela ${ELABOX_HOME}/supernode/ela
cp ${BINARY_DIR}/ela-cli ${ELABOX_HOME}/supernode/ela
chmod +x ${ELABOX_HOME}/supernode/ela/ela ${ELABOX_HOME}/supernode/ela/ela-cli
cp ${BINARY_DIR}/ela_config.json ${ELABOX_HOME}/supernode/ela
mv ${ELABOX_HOME}/supernode/ela/ela_config.json ${ELABOX_HOME}/supernode/ela/config.json
# get did binary and config file
cp ${BINARY_DIR}/did ${ELABOX_HOME}/supernode/did
chmod +x ${ELABOX_HOME}/supernode/did/did
cp ${BINARY_DIR}/did_config.json ${ELABOX_HOME}/supernode/did
mv ${ELABOX_HOME}/supernode/did/did_config.json ${ELABOX_HOME}/supernode/did/config.json
# get carrier binary and config file
cp ${BINARY_DIR}/ela-bootstrapd ${ELABOX_HOME}/supernode/carrier
cp ${BINARY_DIR}/bootstrapd.conf ${ELABOX_HOME}/supernode/carrier
chmod +x ${ELABOX_HOME}/supernode/carrier/ela-bootstrapd
chmod 664 ${ELABOX_HOME}/supernode/carrier/bootstrapd.conf

##############################
# Configure elabox-companion
##############################

cd; git clone https://elaboxx:elabox_2020@github.com/cansulting/elabox-companion
cd elabox-companion
npm install
npm run build

##############################
# Configure elabox-master
##############################

# git clone the server app to correct path
cd /home/elabox/
git clone https://elaboxx:elabox_2020@github.com/cansulting/elabox-master
cd elabox-master
npm install debug --save
npm install
pm2 start index.js --name ebmaster --watch . --time --log /home/elabox/ebmaster.log
pm2 save
