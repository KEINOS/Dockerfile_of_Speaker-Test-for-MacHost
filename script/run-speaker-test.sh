#!/bin/sh

which speaker-test 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  echo 'speaker-test command not found.'
  exit 1
fi

speaker-test -c 2 -l 1 -t wav
