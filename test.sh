v4l2-ctl --set-edid=file=testEDID.txt --fix-edid-checksums
yavta/yavta --capture=1000 -n 3 --encode-to=file.h264 -f UYVY -m -T /dev/video0
