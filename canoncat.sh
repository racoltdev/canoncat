#! /bin/bash

if [[ $# -eq 0 ]]; then
	echo "$(basename "$0") missing required arguments"
	exit
fi

for arg in "$@"; do
	path="$(command -v "${arg}")"; stat=$?
	if [[ ${stat} -ne 0 ]]; then
		echo Invalid path argument \'"${arg}"\' ; exit ${stat};
	fi

	realname="$(readlink -f "${path}")"
	echo "${realname}"
	less -NFXK "${realname}" || exit $?
done;
