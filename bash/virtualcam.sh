#/bin/bash

reload_v4l2loopback () {
	if lsmod | grep v4l2loopback &> /dev/null ; then
		echo -e "\033[33mv4l2loopback already running!\033[0m"
		echo "Unloading v4l2loopback (root required)..."
		sudo rmmod v4l2loopback 
	fi

	echo "Loading v4l2loopback (root required)..."
	sudo modprobe v4l2loopback video_nr=9
}

vid_ffmpeg() {
	echo -e "Starting virtual camera with $1.\nUse \033[32mctrl+C\033[0m to exit"
	ffmpeg -re -stream_loop -1 -i $1 -f v4l2 /dev/video9
}

prnt_help() {
	echo "VIRTUALCAM(1)\n"
	echo -e "\033[32mNAME\033[0m\n\tvirtualcam.sh\n"
	echo -e "\033[32mSYNOPSIS\033[0m\n\tvirtualcam.sh [\033[36mOPTION\033[0m...] [\033[36mFILE\033[0m...]"
	echo -e "\033[32mDESCRIPTION\033[0m\n\n\tA short wrapper for v4l2loopback and ffmeg.\nCreates a virtual camera from a video file."
	echo -e "\033[32mOPTIONS\n\t-file\033[0m Describes the file that is to be used.\n"
	echo -e "\033[32m-help\033[0m Display help for virtualcam.sh."
}

while getopts ":fh:" option;
do
	case $option in
		f) # Run with video from file
			path=$OPTARG 
			reload_v4l2loopback
		 	vid_ffmpeg $path
			exit;;	
		h) # Display help
			prnt_help
			exit;;
		\?) # Invalid input
			echo -e "\033[31mError: Invalid option!\033[0m\nUse -h for information."
			exit;;
	esac
done
