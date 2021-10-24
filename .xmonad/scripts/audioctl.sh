#!/bin/bash
function get_volume {
  pactl -- get-sink-volume 0 | awk -F"[ ]" '/Volume:/ { print $6 }'
  #amixer -c 1 get Master Volume | awk -F"[][%]" '/Mono:/ { print $2 }'
}

function get_artist {
  playerctl -p ncspot metadata --format {{artist}}
}

function get_title {
  playerctl -p ncspot metadata --format {{title}}
}

function get_album_cover {
  curl `playerctl metadata mpris:artUrl | cut -c 1-` -o $imgpath
}

imgpath="/tmp/notification_spotify.png"

case $1 in
  "up")
	pactl -- set-sink-volume 0 +1%;
	echo `get_volume` > /tmp/xob_vol;
	;;

  "down")
	pactl -- set-sink-volume 0 -1%;
	echo `get_volume` > /tmp/xob_vol;
#	dunstify -r 10 `get_volume`"%" -a "Volume"
	;;

  "next")
	playerctl -p ncspot next
	get_album_cover
	dunstify "`get_artist`" "`get_title`" -I $imgpath -r 20 -a "Now playing..."
	;;
  "prev")
  	playerctl -p ncspot previous
	get_album_cover
	dunstify "`get_artist`" "`get_title`" -I $imgpath -r 20 -a "Now playing..."
	;;
  "play-pause")
	playerctl -p ncspot play-pause
	get_album_cover
	if [ `playerctl -p ncspot metadata --format {{status}}` = "Playing" ]; then
	    dunstify "`get_artist`" "`get_title`" -I $imgpath -r 20 -a "Now playing..."

	else
	    dunstify "`get_artist`" "`get_title`" -I $imgpath -r 20 -a "Paused!"
	fi

	;;
   *)
	dunstify "`get_artist`" "`get_title`" -I $imgpath -r 20 -a "Now playing..."
	;;
esac
