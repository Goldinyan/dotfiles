#!/bin/zsh

project="$1"

if  ! z "$project";  then
	echo "Usage: $0 <ProjectName>"
	exit 1
fi

nvim



