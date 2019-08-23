#!/usr/bin/env python3
#

import paho.mqtt.client as mqtt
import shutil
from subprocess import Popen, call
from time import sleep


class InfobordController:

    def __init__(self, *args, **kwargs):
        self.mq = mqtt.Client()
        self.bitlair_open = False
        self.djo_open = False
        self.browser = None

        self.mq.on_connect = self.on_space_connected
        self.mq.on_message = self.on_space_message
        self.mq.connect('mqtt.bitlair.nl', 1883, 60)
        self.mq.loop_start()

    def force_screen_on(self):
        call(['/usr/bin/xset', 's', 'off'])
        call(['/usr/bin/xset', 's', 'noblank'])
        call(['/usr/bin/xset', 's', '0 0'])
        call(['/usr/bin/xset', 'dpms', 'force', 'on'])
        call(['/usr/bin/xset', 'dpms 0 0 0'])
        call(['/usr/bin/xset', '-dpms'])

    def force_screen_off(self):
        call(['/usr/bin/xset', 'dpms', 'force', 'off'])

    def on_space_connected(self, client, userdata, flags, rc):
        print("Connected to MQTT broker")
        client.subscribe('bitlair/state/djo')
        client.subscribe('bitlair/state')

    def on_space_message(self, client, userdata, msg):
        print("Message: {0}: {1}".format(msg.topic, msg.payload))

        if msg.topic == 'bitlair/state/djo':
            if msg.payload == b'open':
                print("DJO is open!")
                self.djo_open = True
            else:
                print("DJO is closed :(")
                self.djo_open = False
        elif msg.topic == 'bitlair/state':
            if msg.payload == b'open':
                print("Bitlair is open!")
                self.bitlair_open = True
            else:
                print("Bitlair is closed :(")
                self.bitlair_open = False

    def stop_browser(self):
        # Kill existing browser
        if self.browser:
            self.browser.terminate()
            self.browser.wait()
            self.browser = None

    def start_browser(self, url):
        self.stop_browser()
        shutil.rmtree('/home/pi/.config/chromium', True)
        self.force_screen_on()
        self.browser = Popen(['/usr/bin/chromium-browser', '--start-fullscreen', '--disable-features=TranslateUI', '--app', url])

    def loop(self):
        while True:
            sleep(5)
            if self.djo_open:
                if self.browser is None:
                    self.start_browser("https://infobord.djoamersfoort.nl")
            elif self.bitlair_open:
                if self.browser is None:
                    self.start_browser("https://bitlair.nl/Hoofdpagina")
            else:
                # Nothing open -> DPMS standby
                print("Nothing to show, turning off screen...")
                self.stop_browser()
                self.force_screen_off()

            if self.browser:
                status = self.browser.poll()
                if status is not None:
                    # Browser was killed -> restart it
                    self.browser = None


def main():
    infobord = InfobordController()
    infobord.loop()


if __name__ == '__main__':
    main()
