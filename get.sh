#!/bin/bash
i=5679
while true
do
  i=$((i+1))
  fn="_XXX${i}.JPG"
  if [ ! -f "${fn}" ]
  then
    wget --no-check-certificate "https://teststats.cncf.io/backups/e38/${fn}"
    res=$?
    echo "$i -> $res"
    if [ ! "$res" = "0" ]
    then
      echo "cannot get ${fn}, exiting"
      break
    fi
  else
    echo "we already have ${fn}"
  fi
done
