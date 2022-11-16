#!/bin/bash

dvdoc '{
  "sample": "s [-]",
  "description": "Search for a file for later, or recall last file searched for"
}' $0 $@ && exit

lastfile=~/.config/dv/last-s.txt
shist=~/.config/dv/s-hist.txt

if [ "$1" = "-" ]
then
  cat $lastfile
elif [ "$1" = "hist" ]
then
  cat $shist
else
  res=$(FZF)
  echo $res > $lastfile
  echo $res >> $shist
  echo $res | pbcopy
fi
