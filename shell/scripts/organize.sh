#!/usr/bin/env sh

organize(){
	src_dir=$1
	replace_space "$src_dir"
	filenames=$(find "$src_dir" -mindepth 1 -maxdepth 1 -type f -print0 | xargs -0 -I {} basename {})
	[ -z "$filenames" ] && return 0
	echo "$filenames"
	echo "$filenames" | rev | cut -d "." -f 1 | rev | xargs -0 -I {} mkdir -p "$src_dir"/{}
	for file in $filenames; do
		file_extension=$(echo "$file" | rev | cut -d "." -f 1 | rev)
		mv "$src_dir"/"$file" "$src_dir"/"$file_extension"
	done
}

check_spaces(){
	[ -z "$2" ] && set -- "$1" "f"
	find "$1" -mindepth 1 -maxdepth 1 -type "$2" -name "* *" -print0
}

replace_space(){
	src_dir="$1"
	replace_char="$2"
	[ -z "$replace_char" ] && set -- "$1" "$2"
	[ -z "$src_dir" ] && echo "Usage: replace_space <src_dir> <replace_char>"
	[ -z "$(check_spaces "$src_dir")" ] && return 0
	check_spaces "$src_dir" | sed -z 'p;s/ /'"$replace_char"'/g' | xargs -0 -n2 mv --
}
