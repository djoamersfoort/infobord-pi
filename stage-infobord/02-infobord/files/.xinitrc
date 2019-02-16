/usr/bin/openbox &
/usr/bin/xdotool mousemove 9999 9999
rm -rf /home/pi/.config/chromium
while /bin/true; do
  /home/pi/infobord-controller.py
  echo "Controller aborted, restarting..."
  sleep 10
done
