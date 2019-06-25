#!/bin/bash

function escape {
    echo "$@" | sed -e 's/[]\/$*.^[]/\\&/g'
}

function insert_file {
  target=$1
  cmd="$2"
  before="$3"
  if ! grep -q "$(escape $cmd)" $target; then
    if [ -z "$before"] || ! grep -q "$before" $target ; then
      echo "Appending $cmd to $target"
      echo "$cmd" >> $target
    else
      echo "Appending $cmd to $target before $before"
      sed "/^$(escape $before)/i $(escape $cmd)" -i $target 
    fi
  fi
}

function confirm { 
  read -p "$1" -n 1 -r && echo && [[ $REPLY =~ ^[Yy]$ ]]
  return $?
}
