#!/usr/bin/env bash
set -o errexit
set -o pipefailx

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@" ]

apt-get updates
apt-get install -y build-essential dkms
$VERSION=`wget -qO- --no-check-certificate https://github.com/amzn/amzn-drivers/releases | sed -n 's|.*/archive/ena_linux_\(.*\).tar.gz.*|\1|p' | awk '{ print $1; exit }'`
git clone https://github.com/amzn/amzn-drivers /usr/src
mv /usr/src/amzn-drivers /usr/src/amzn-drivers-${VERSION}
cat > /usr/src/amzn-drivers-${VERSION}/dkms-test1.conf << EOF
PACKAGE_NAME="ena"
PACKAGE_VERSION="{VERSION}"
CLEAN="make -C kernel/linux/ena clean"
MAKE="make -C kernel/linux/ena/ BUILD_KERNEL=\${kernelver}"
BUILT_MODULE_NAME[0]="ena"
BUILT_MODULE_LOCATION="kernel/linux/ena"
DEST_MODULE_LOCATION[0]="/updates"
DEST_MODULE_NAME[0]="ena"
AUTOINSTALL="yes"
EOF

dkms add -m amzn-drivers -v ${VERSION}
dkms build -m amzn-drivers -v ${VERSION}
dkms install -m amzn-drivers -v ${VERSION}
update-initramfs -c -k all