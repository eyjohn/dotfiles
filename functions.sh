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
      echo "Inserting $cmd to $target before $before"
      sed "/^$(escape $before)/i $(escape $cmd)\n" -i $target
    fi
  fi
}

function prepend_file {
  target=$1
  cmd="$2"
  if ! grep -q "$(escape $cmd)" $target; then
    echo "Prepending $cmd to $target"
    sed "1s/^/$(escape $cmd)\n/" -i $target 
  fi
}

function confirm { 
  read -p "$1" -n 1 -r && echo && [[ $REPLY =~ ^[Yy]$ ]]
  return $?
}

function is_linux {
  if [[ $(uname) =~ "Linux" ]]; then
      true
  else
      false
  fi
}

function has_apt {
  if which apt-get &> /dev/null; then
    true
  else
    false
  fi
}