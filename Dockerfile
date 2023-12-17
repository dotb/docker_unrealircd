FROM debian:bookworm

ARG UNREAL_VERSION 

RUN <<EOF 
apt update
apt -y install apt-utils wget build-essential pkg-config gdb libssl-dev libpcre2-dev libargon2-0-dev libsodium-dev libc-ares-dev libcurl4-openssl-dev
apt -y install libssl3 libpcre2-32-0 libargon2-0 libsodium23 libc-ares2 libcurl4
adduser --disabled-password --gecos 'IRCd' ircd
cd /home/ircd
wget https://www.unrealircd.org/downloads/unrealircd-$UNREAL_VERSION.tar.gz
wget https://www.unrealircd.org/downloads/unrealircd-$UNREAL_VERSION.tar.gz
tar -xvf *.tar.gz
EOF

ADD config.settings /home/ircd/unrealircd-$UNREAL_VERSION/config.settings
ADD init /init
ADD status /status

RUN <<EOF
cd /home/ircd
cd unrealircd-$UNREAL_VERSION
./Config -quick
make
make install
cd /usr/local/unrealircd
chown -R ircd:ircd * 
cd /home/ircd
chown ircd:ircd boot.sh
chmod 755 boot.sh
# Cleanup the build environment
rm -fR unrealircd*
apt-get --purge -y remove apt-utils wget build-essential pkg-config gdb libssl-dev libpcre2-dev libargon2-0-dev libsodium-dev libc-ares-dev libcurl4-openssl-dev
apt -y autoremove
EOF

EXPOSE 6667
EXPOSE 6697

ENTRYPOINT ["/init"]
