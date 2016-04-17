
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

Grab the PKGBUILD from the AUR[1].

### systemd

The PKGBUILD would install the systemd service file `opennic.service` to the
systemd directory `/usr/lib/systemd/system`. For custom service files, the
recommended path is `/etc/systemd/system`

### Other init systems

Install the `opennic.sh` in `/usr/local/bin` (or `/usr/bin`) and make the boot
scripts run the script on boot after connecting to the network.

[0] http://www.opennicproject.org/geoip/geotxt4.txt
[1] https://aur.archlinux.org/packages/opennic-git/
