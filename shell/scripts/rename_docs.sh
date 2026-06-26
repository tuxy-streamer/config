#!/usr/bin/env sh

rename_doc(){
	filename=$1
	tag=$2
	newname=$3
	[ -z "$tag" ] && [ -z "$filename" ] && echo "Usage: rename_doc <filename> <tag> <newname>" && return 1
	[ -z "$newname" ] && newname="$filename"
	createdat=$(stat -c "%w" "$filename" | awk '{print $1}')
	extension=$(echo "$filename" | cut -d "." -f 2)
	mv "$filename" "$createdat-$tag-$newname.$extension"
}
