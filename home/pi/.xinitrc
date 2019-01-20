/usr/bin/openbox &
/usr/bin/xdotool mousemove 9999 9999
while /bin/true; do
  /home/pi/inforbord-controller.py
done
