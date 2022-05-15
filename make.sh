#!/bin/bash
# params: width height n_per_line
width=400
height=300
n_per_line=6
if [ ! -z "$1" ]
then
  width="${1}"
fi
if [ ! -z "$2" ]
then
  height="${2}"
fi
if [ ! -z "$3" ]
then
  n_per_line="${3}"
fi
cp head.html index.html
i=0
for f in *.JPG
do
  preview="preview_${width}x${height}_${f}"
  if [ ! -f "${preview}" ]
  then
    echo "generating ${preview} preview"
    convert "${f}" -geometry "${width}x${height}" -quality 80% "${preview}"
  fi
  echo "<a href=\"./${f}\"><img src=\"./${preview}\" alt=\"${f}\" style=\"width:${width}px;height:${height}px;\"></a>" >> index.html
  i=$((i+1))
  if [ "$i" = "$n_per_line" ]
  then
    i=0
    echo "<br />" >> index.html
  fi
done
cat tail.html >> index.html
