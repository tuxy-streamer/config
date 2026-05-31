#!/usr/bin/env sh

nightlight_toggle(){
    { [ $(pgrep -x "hyprsunset") ] && killall -KILL hyprsunset && notify-send "Night Light" "OFF" --urgency=low; } ||
        { hyprsunset & notify-send "Night Light" "ON" --urgency=low; }
}
