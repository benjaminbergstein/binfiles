#!/bin/bash

dvdoc '{
  "sample": "v",
  "description": "View git history"
}' $0 $@ && exit

git log -p
