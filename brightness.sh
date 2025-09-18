#! /bin/bash
# USAGE  : bash ~/misc/brightness.sh +1000
# GET MAX: pkexec xfpm-power-backlight-helper --get-max-brightness
backlight_cur=$(pkexec xfpm-power-backlight-helper --get-brightness)
backlight_max=$(pkexec xfpm-power-backlight-helper --get-max-brightness)
backlight_tick=$(( $backlight_max / 20 ))
if [[ $1 = "d" ]]; then
  backlight_cur=$(( $backlight_cur - $backlight_tick ))
  if [[ $backlight_cur -lt 5 ]]; then
    backlight_cur=5
  fi
else
  backlight_cur=$(( $backlight_cur + $backlight_tick ))
  if [[ $backlight_cur -gt $backlight_max ]]; then
    backlight_cur=$backlight_max
  fi
fi
echo $backlight_new
pkexec xfpm-power-backlight-helper --set-brightness $backlight_cur

