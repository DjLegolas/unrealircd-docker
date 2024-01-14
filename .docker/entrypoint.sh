#!/usr/bin/env sh

CERT_PATH=/app/conf/tls
CERT_KEY_PATH=$CERT_PATH/server.key.pem
CERT_PUB_PATH=$CERT_PATH/server.cert.pem
CERT_REQ_PATH=$CERT_PATH/server.req.pem

# generate ssl certificates
if [ ! -f $CERT_PUB_PATH ]; then
  OPENSSL_PATH=`which openssl`
  if [ ! -f $OPENSSL_PATH ]; then
    echo "openssl is not installed"
    exit 1
  fi

  $OPENSSL_PATH ecparam -out $CERT_KEY_PATH -name secp384r1 -genkey || exit 1
  $OPENSSL_PATH req -new -sha256 -out $CERT_REQ_PATH -key $CERT_KEY_PATH -nodes -subj "/O=IRC geeks/OU=IRCd" || exit 1
  $OPENSSL_PATH req -x509 -days 3650 -sha256 -nodes -in $CERT_REQ_PATH -key $CERT_KEY_PATH -out $CERT_PUB_PATH || exit 1

  chmod o-rwx $CERT_REQ_PATH $CERT_KEY_PATH $CERT_PUB_PATH
  chmod g-rwx $CERT_REQ_PATH $CERT_KEY_PATH $CERT_PUB_PATH
fi

/usr/unrealircd/bin/unrealircd -F
