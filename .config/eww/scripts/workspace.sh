#! /bin/bash

#define icons for workspaces 1-9
ic=(0   󱐎  󰻧     )

workspaces() {

  o1=0
  o2=0
  o3=0
  o4=0
  o5=0
  o6=0
  o7=0
  o8=0
  o9=0
  f1=0
  f2=0
  f3=0
  f4=0
  f5=0
  f6=0
  f7=0
  f8=0
  f9=0

  # Get occupied workspaces and remove workspace -99 aka scratchpad if it exists
  # a="$(hyprctl workspaces | grep ID | awk '{print $3}')"
  # a="$(echo "${a//-99/}" | sed '/^[[:space:]]*$/d')"
  ows="$(hyprctl workspaces -j | jq '.[] | del(select(.id == -99)) | del(select(.windows==0)) | .id')"

  for num in $ows; do
    export o"$num"="$num"
  done

  # Get Focused workspace for current monitor ID
  arg="$1"
  num="$(hyprctl monitors -j | jq --argjson arg "$arg" '.[] | select(.id == $arg).activeWorkspace.id')"
  export f"$num"="$num"

  echo 	"(eventbox :onscroll \"echo {} | sed -e 's/up/-1/g' -e 's/down/+1/g' | xargs hyprctl dispatch workspace\" \
            (box	:class \"workspace$1\"	:orientation \"h\" :space-evenly \"true\" :halign \"start\"	\
                (button :onclick \"scripts/dispatch.sh 1\" :class \"w0$o1$f1\" \"${ic[1]}\") \
                (button :onclick \"scripts/dispatch.sh 2\" :class \"w0$o2$f2\" \"${ic[2]}\") \
                (button :onclick \"scripts/dispatch.sh 3\" :class \"w0$o3$f3\" \"${ic[3]}\") \
                (button :onclick \"scripts/dispatch.sh 4\" :class \"w0$o4$f4\" \"${ic[4]}\") \
                (button :onclick \"scripts/dispatch.sh 5\" :class \"w0$o5$f5\" \"${ic[5]}\") \
                (button :onclick \"scripts/dispatch.sh 6\" :class \"w0$o6$f6\" \"${ic[6]}\") \
                (button :onclick \"scripts/dispatch.sh 7\" :class \"w0$o7$f7\" \"${ic[7]}\") \
                (button :onclick \"scripts/dispatch.sh 8\" :class \"w0$o8$f8\" \"${ic[8]}\") \
                (button :onclick \"scripts/dispatch.sh 9\" :class \"w0$o9$f9\" \"${ic[9]}\") \
            )\
          )"
}

workspaces $1
socat -u UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read -r; do
workspaces $1
done
