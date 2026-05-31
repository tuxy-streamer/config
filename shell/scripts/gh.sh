#!/usr/bin/env sh

ghrd(){
    selected=$(gh repo list | awk '{print $1}' | fzf)
    gh repo delete "$selected" --yes
}

ghrc(){
    selected=$(gh repo list | awk '{print $1}' | fzf)
    gh repo clone "$selected"
}
