#!/bin/bash
#
# Copyright (c) 2015-2016, mar77i <mysatyre at gmail dot com>
#
# This software may be modified and distributed under the terms
# of the ISC license.  See the LICENSE file for details.

host="api.opennicproject.org"
api_ip=173.160.58.201
get_rq="resolv&res=5"
version=0.2

curlopts=(
	'-s'
	--resolve "${host}:443:${api_ip}"
)

output="/etc/resolv.conf"

while (( $# > 0 )); do
	case "$1" in
	"--help")
		echo "$0 [--output <file>] | --help | --version"
		echo "--output <file>  Set the output file (default: ${output})"
		echo "--version        Display version information"
		echo "--help           Display this help message"$'\n'
		echo "Note: run $0 as a user, preferably root"
		echo "      which may write to ${output}"
		exit 0
		;;
	'--version')
		echo "$0 version $version"
		exit 0
		;;
	'--output'|'-o')
		# write output to terminal: ./opennic.sh -o /dev/stdout
		output="$2"
		shift
		;;
	*)
		echo "Error: invalid arguments." >&2
		exit 1
		;;
	esac
	shift
done

dns="$(curl "${curlopts[@]}" "https://${host}/geoip/?${get_rq}")"
if [[ $? == 0 && -n "$dns" ]]; then
	echo "$dns" >"$output"
else
	echo "Error: could not download opennic dns information." >&2
	exit 1
fi

exit 0
