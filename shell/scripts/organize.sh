#!/usr/bin/env sh

replace_spaces() {
  src_dir=$1
  for file in "$src_dir"/*; do
    [ -f "$file" ] || continue
    base=${file##*/}
    newbase=$(printf '%s' "$base" | tr ' ' '-')
    [ "$base" = "$newbase" ] || mv -- "$file" "$src_dir/$newbase"
  done
}

organize() {
  src_dir=$1
  replace_spaces "$src_dir"
  for file in "$src_dir"/*; do
    [ -f "$file" ] || continue
    base=${file##*/}
    ext=${base##*.}
    if [ "$base" = "$ext" ]; then
      target_dir="$src_dir/no_extension"
    else
      target_dir="$src_dir/$ext"
    fi
    [ -d "$target_dir" ] || mkdir -- "$target_dir"
    mv -- "$file" "$target_dir/"
  done
}
