#! /bin/bash
# TODO add help file

if [[ $# -eq 0 ]]; then
	echo "$(basename "$0") missing required arguments"
	exit
fi

pipe=0
while [[ $# -gt 0 ]]; do
	case $1 in
		-p)
			pipe=1
			shift
			;;
		*)
			break
	esac
done

declare -a realnames
index=0
for arg in "$@"; do

	# $? is exit status from previous command
	path="$(command -v "${arg}")"; stat=$?
	if [[ ${stat} -ne 0 ]]; then
		echo Invalid path argument \'"${arg}"\' ; exit "${stat}";
	fi

	realnames+=("$(readlink -f "${path}")")
	index=${index}+1

done;

if [[ "${pipe}" -eq 0 ]]; then
	lessprompt=$'%F | file %i/%m | line %lb/%L \: %Pb\% | \'\:n/p\'=next/prev file, \'q\'=quit'
	# line numbers, close if one screen, don't wipe screen on quit, respond to interrupt, use verbose prompt
	less -NFXM \
		--line-num-width=4 \
		--tabs=4 \
		--use-color \
		-DNbk `# line number colors` \
		-DPBkd `# prompt colors` \
		-PM"${lessprompt}" `# prompt` \
		"${realnames[@]}"

	for name in "${realnames[@]}"; do
		echo "$name"
	done
else
	for name in "${realnames[@]}"; do
		echo -n "\"$name\" "
	done
fi
