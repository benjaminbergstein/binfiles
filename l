#!/bin/bash

git co $(git branch --sort=-committerdate | grep -v '*' | FZF)
