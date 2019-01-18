/usr/bin/xset s noblank
/usr/bin/xset s 0 0
/usr/bin/xset dpms 0 0 0
/usr/bin/xset -dpms
/usr/bin/openbox &
/usr/bin/xdotool mousemove 9999 9999
while /bin/true; do
  /usr/bin/chromium-browser --start-fullscreen --app="https://infobord.djoamersfoort.nl/"
done

