
# opennic DNS resolving

Service to grab the nearest dns service from [OpenNIC][0].
Using the fixed ip, the three nearest opennic servers, as listed by the [API][1]
will be written to `/etc/resolv.conf`.

If the OpenNIC lookup fails, it's possible to replace the error message with a
default DNS lookup address, as in this patch.

Please note that DHCP clients like `dhcpcd` tend to have mechanisms in place to
update the `/etc/resolv.conf`. As opennic relies on an IP to be resolved over
the net, the changes made to said file would be overwritten by opennic.

## Installation

### Archlinux

Grab the PKGBUILD from the [AUR][2].

### systemd

The PKGBUILD would install the systemd service file `opennic.service` to the
systemd directory `/usr/lib/systemd/system`. For custom service files, the
recommended path is `/etc/systemd/system`.

### Other init systems

Install the `opennic.sh` in `/usr/local/bin` (or `/usr/bin`) and make the boot
scripts run the script on boot after connecting to the network.

[0]: https://www.opennicproject.org/
[1]: https://api.opennicproject.org/geoip/?resolv
[2]: https://aur.archlinux.org/packages/opennic-git
