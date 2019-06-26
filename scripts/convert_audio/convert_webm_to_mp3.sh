#!/bin/bash
# Convert A webm file or folder to mp3
# https://bytefreaks.net/gnulinux/bash/ffmpeg-extract-audio-from-webm-to-mp3

## Requires ffmpeg

# For converting webms where the webm is a folder and the playback file is in inside called 'videoplayback'
for FILE in *.webm; do
  echo -e "Processing video '\e[32m$FILE\e[0m'";
  ffmpeg -i "${FILE}/videoplayback" -vn -ab 128k -ar 44100 -y "${FILE%.webm}.mp3";
done;

# For converting webms where the webm is a single file
for FILE in *.webm; do
  echo -e "Processing video '\e[32m$FILE\e[0m'";
  ffmpeg -i "${FILE}" -vn -ab 128k -ar 44100 -y "${FILE%.webm}.mp3";
done;

