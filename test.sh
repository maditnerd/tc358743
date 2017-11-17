v4l2-ctl --set-edid=file=testEDID.txt
yavta/yavta -f UYVY --capture=100000 -n 3 --encode-to=- -m -T /dev/video0 | ffmpeg -y -r 25 -i - -vcodec copy /dev/shm/tmp.mp4
