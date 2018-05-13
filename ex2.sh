#!/bin/bash

cd /proc

printf "%-30s %b " "Name"
printf "%-10s %b " "Pid"
printf "%-10s %b " "PPid"
printf "%-30s %b " "Status"
printf "%-10s %b \n" "Files opened"

for file in *
do
  if [ -d $file ] && [ -r $file ]
  then
    cd $file
    if [ -e status ]
    then
      name=$( echo `sed '1q;d' status` | sed -e "s/Name://" | sed -e "s/\///" | sed "s/[[:blank:]]//g" )
      pid=$( echo `sed '6q;d' status` | sed -e "s/Pid://" | sed -e "s/\///" | sed "s/[[:blank:]]//g"  )
      ppid=$( echo `sed '7q;d' status` | sed -e "s/PPid://" | sed -e "s/\///" | sed "s/[[:blank:]]//g" )
      status=$( echo `sed '3q;d' status` | sed -e "s/State://" | sed -e "s/\///" | sed "s/[[:blank:]]//g" )

      if [ -r 'fd' ]
      then
        files=$( ls fd | wc -l )
      else
        files='0'
      fi

      printf "%-30s %b " $name
      printf "%-10s %b " $pid
      printf "%-10s %b " $ppid
      printf "%-30s %b " $status
      printf "%-10s %b \n" $files

      cd ..
    fi
  fi
done