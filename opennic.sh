#!/bin/bash

if (( $# > 0 )); then
	(( $# == 1 )) && case "$1" in
	"--help")
		echo "$0 [--help|--version]"
		echo "--version  Display version information"
		echo "--help     Display this help message"
		echo $'\nNote: $0 must be run as the root user and enabled to' \
			'modify /etc/resolv.conf'
		exit 0
		;;
	*)
		;;
	esac
	echo "Error: invalid arguments." >&2
	exit 1
fi

if (( $UID )); then
	echo "Error: this script must be run as root." >&2
	exit 1
fi

retry_curl() {
	local i
	for (( i=0; i<5; i++ )); do
		curl "$@"
		[[ $? != 7 ]] && break
		sleep 1
	done
}

if dns="$(retry_curl -s "http://75.127.96.89/geoip/geotxt4.php")" && \
  [[ -n "$dns" ]]; then
	printf '# Generated by opennic\n%s\n' "$dns">/etc/resolv.conf
else
	echo "Error: could not download opennic dns information." >&2
	exit 1
fi

exit 0
