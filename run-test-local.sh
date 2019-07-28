#!/bin/bash

# Run this script localy from your macOS.
# If you hear "Front, left. Front, right." then the container is working properly.

name_image='keinos/speaker-test:latest'

function isPulseAudioUp(){
    pulseaudio --check -v > /dev/null 2>&1
    if [ $? -ne 0 ]; then
      return 1
    fi
    return 0
}

function isCommandAvailable(){
    which $1 > /dev/null 2>&1
    if [ $? -ne 0 ]; then
      return 1
    fi
    return 0
}

isCommandAvailable sw_vers || {
  echo '- Not a macOS. This script is for macOS only.'
  exit 1
}

isCommandAvailable pulseaudio || {
  echo '- pulseaudio is not installed. Install it by:'
  echo '  $ brew install pulseaudio'
  exit 1
}

isCommandAvailable docker || {
  echo '- docker is not installed. Install it by:'
  echo '  $ brew cask install docker'
  exit 1
}

isPulseAudioUp || {
  echo '- pulseaudio is not running.'
  echo -n '  running pulseaudio daemon ... '
  pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon > /dev/null 2>&1
}

isPulseAudioUp || {
  echo '- Can not run pulseaudio.'
  exit 1
}

docker image ls | grep $name_image > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo '- No image found.'
  echo '  Pulling image ...'
  docker pull $name_image
fi

docker run --rm -it -v ~/.config/pulse:/home/pulseaudio/.config/pulse $name_image
if [ $? -ne 0 ]; then
  echo '- Fail to run docker container.'
  exit 1
fi

echo 'DONE.'
echo 'Did you hear the sample sound?'
exit 0
