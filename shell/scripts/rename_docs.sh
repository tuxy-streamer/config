#!/usr/bin/env sh

rename_doc(){
	filename=$1
	tag=$2
	newname=$3
	[ -n "$tag" ] && [ -z "$filename" ] || echo "Usage: rename_doc <filename> <tag> <newname>" && return 1
	[ -n "$newname" ] || newname="$filename"
	createdate=$(stat -c "%w" "$filename" | awk '{print $1}')
	extension=$(echo "$filename" | cut -d "." -f 2)
	mv "$filename" "$createdate-$tag-$newname.$extension"
}
