#!/bin/bash
# build-deb.sh — Download the .run installer and build the .deb package
set -e

INSTALLER_URL="https://photoneo.com/files/dw/dw/pxc/1.16/PhotoneoPhoXiControlInstaller-1.16.4-Ubuntu22-STABLE.tar.gz"
INSTALLER_TARBALL="PhotoneoPhoXiControlInstaller-1.16.4-Ubuntu22-STABLE.tar.gz"
INSTALLER_RUN="PhotoneoPhoXiControlInstaller-1.16.4-Ubuntu22-STABLE.run"
PACKAGE_DIR="phoxicontrol-deb"
OUTPUT_DEB="phoxicontrol_1.16.4_amd64.deb"

if [ -f "$PACKAGE_DIR/opt/photoneo/installer/$INSTALLER_RUN" ]; then
    echo "==> Installer already present in package tree, skipping download."
else
    echo "==> Downloading installer tarball..."
    wget -q "$INSTALLER_URL" -O "/tmp/$INSTALLER_TARBALL"

    echo "==> Extracting .run file..."
    tar -xf "/tmp/$INSTALLER_TARBALL" -C /tmp/
    rm "/tmp/$INSTALLER_TARBALL"

    echo "==> Placing .run file into package tree..."
    cp "/tmp/$INSTALLER_RUN" "$PACKAGE_DIR/opt/photoneo/installer/"
    chmod +x "$PACKAGE_DIR/opt/photoneo/installer/$INSTALLER_RUN"
    rm "/tmp/$INSTALLER_RUN"
fi

echo "==> Building .deb package..."
dpkg-deb --build --root-owner-group "$PACKAGE_DIR" "$OUTPUT_DEB"

echo ""
echo "Done! Package built: $OUTPUT_DEB"
echo ""
echo "Install with:"
echo "  sudo apt-get install ./$OUTPUT_DEB"
echo ""
echo "Upload with:"
printf '  jf rt upload phoxicontrol_1.16.4_amd64.deb "tecnalia-robotics-debian-dev-local/pool/main/p/phoxicontrol/phoxicontrol_1.16.4_amd64.deb" --target-props "deb.distribution=noble;deb.component=main;deb.architecture=amd64" --server-id tecnalia\n'