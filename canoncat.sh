#! /bin/bash

if [[ $# -eq 0 ]]; then
	echo "$(basename "$0") missing required arguments"
	exit
fi

for arg in "$@"; do
	# $? is exit status from previous command
	path="$(command -v "${arg}")"; stat=$?
	if [[ ${stat} -ne 0 ]]; then
		echo Invalid path argument \'"${arg}"\' ; exit "${stat}";
	fi

	realname="$(readlink -f "${path}")"
	echo "${realname}"
	# line numbers, close if one screen, don't wipe screen on quit, respond to interrupt, use verbose prompt
	less -NFXKM \
		--line-num-width=4 \
		--use-color \
		-DNbk `# line number colors` \
		-DPBkd `# prompt colors` \
		-PM"%F | file %i/%m | line %lb/%L \: %Pb\%"$ `# prompt` \
		"${realname}" || exit $?

done;
