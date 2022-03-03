#/bin/bash

if lsmod | grep v4l2loopback &> /dev/null ; then
	echo -e "\033[33mv4l2loopback already running!\033[0m"
	echo "Unloading v4l2loopback (root required)..."
	sudo rmmod v4l2loopback 
fi

echo "Loading v4l2loopback (root required)..."
sudo modprobe v4l2loopback video_nr=9

echo -e "Starting virtual camera, use \033[32mctrl+C\033[0m to exit"
ffmpeg -re -stream_loop -1 -i $1 -f v4l2 /dev/video9
