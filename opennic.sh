#!/bin/bash

host="api.opennicproject.org"
api_ip=173.160.58.201
get_rq="resolv&res=5"
version=0.1

curlopts=(
	'-s'
	--resolve "${host}:443:${api_ip}"
)

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
	'--version')
		echo "$0 version $version"
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

dns="$(curl "${curlopts[@]}" "https://${host}/geoip/?${get_rq}")"
if [[ $? == 0 && -n "$dns" ]]; then
	echo "$dns" >/etc/resolv.conf
else
	echo "Error: could not download opennic dns information." >&2
	exit 1
fi

exit 0
