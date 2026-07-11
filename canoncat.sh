#! /bin/bash

if [[ $# -eq 0 ]]; then
	echo $(basename $0) missing required arguments
	exit
fi

for arg in $@; do
	which $arg | xargs readlink -f | xargs -r0 bash -c 'echo $@; cat $@ -n | more' '';
done;
