#!/usr/bin/env sh

ac_go(){
	pattern="PASS"
	go test -v
	while true; do
		printf "\n"
		inotifywait -qe create,modify,delete,move --format '%e' . >/dev/null
		go test -v
		result=$(go test -v | grep "$pattern" )
		msg=$(commit_msg_generator)
		echo "$msg"
		[ -n "$result" ] && git commit -am "$msg"
	done
}

ac(){
	env=$1
	case "$env" in
		go)
			tdd_go
			;;
		*)
			command ...
			;;
	esac
}

commit_msg_generator() {
  adds=$(git diff | grep '^+' | grep -v '+++' | grep -Evc '^\+[[:blank:]]*$')
  dels=$(git diff | grep '^-' | grep -v '^---' | grep -Evc '^-[[:blank:]]*$')
  changed=$((adds + dels))
  [ "$dels" -eq 0 ] && ratio=999 || ratio=$((adds * 100 / dels))
  msg_type="feat"
  [ "$changed" -gt 0 ] && [ "$changed" -lt 10 ] && [ "$ratio" -ge 90 ] && [ "$ratio" -le 110 ] && msg_type="fix"
  [ "$changed" -ge 10 ] && [ "$ratio" -ge 80 ] && [ "$ratio" -le 120 ] && msg_type="refactor"
  action="update"
  [ "$adds" -gt 0 ] && [ "$dels" -eq 0 ] && action="add"
  [ "$adds" -eq 0 ] && [ "$dels" -gt 0 ] && action="delete"
  file=$(git diff --name-only | head -n 1 | xargs basename)
  [ -n "$file" ] || file="code"
  echo "$msg_type: $action $file"
}   
