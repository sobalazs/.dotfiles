#!/bin/bash
shutdown="shutdown";
reboot="reboot";
llogout="logout";
options="$llogout\n$reboot\n$shutdown"

PRESELECTION=
bg="/usr/share/pixmaps/boat_girl.png"

selected="$(echo -e "$options" | rofi -theme pmenu_theme.rasi \
                 -fake-background ${bg} -fake-transparency \
		 -p "See you later, ${LOGNAME^}!" -dmenu -selected-row ${PRESELECTION})"
echo "Ezt választottad: "$selected
case $selected in
  $llogout)
    session=`loginctl session-status | head -n 1 | awk '{print $1}'`
    loginctl terminate-session $session
    ;;
  $reboot)
    systemctl reboot
    ;;
  $shutdown)
    systemctl poweroff
    ;;
esac
