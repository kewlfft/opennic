
# opennic DNS resolving

Service to grab the nearest dns service from http://www.opennicproject.org/
Using the fixed ip, the three nearest opennic servers, as listed by [0] will be
written to `/etc/resolv.conf`.

If the opennic lookup fails, it's possible to replace the error message with a
default dns lookup address, as in this patch

Please note that DHCP clients like `dhcpcd` tend to have mechanisms in place to
update the `/etc/resolv.conf`. As opennic relies on an IP to be resolved over
the net, the changes made to said file would be overwritten by opennic.

## Installation

### Archlinux

Grab the PKGBUILD from the AUR here [1]

### systemd

The PKGBUILD would install the systemd service file `opennic.service` to the
systemd directory `/usr/lib/systemd/system`. For custom service files, the
recommended path is `/etc/systemd/system`

### Other init systems

Install the `opennic.sh` in `/usr/local/bin` (or `/usr/bin`) and make the boot
scripts run the script on boot after connecting to the network.

## Security considerations

QUANTUM packet injection is an attack vector for plaintext HTTP connections.<br>
Opennicproject.org staff is working on building a cryptographic web of trust and
is in the course of implementing HTTPS.
The current version however doesn't account for any of these things.

[0] http://www.opennicproject.org/geoip/geotxt4.txt
[1] <insert aur url here>
