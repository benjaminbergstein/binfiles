#!/bin/bash

lastfile=~/.config/dv/last-s.txt

if [ "$1" = "-" ]
then
  cat $lastfile
else
  res=$(FZF)
  echo $res > $lastfile
  echo $res | pbcopy
fi
