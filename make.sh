#!/bin/bash
# params: width height n_per_line or PERC=5
width=400
height=300
n_per_line=6
zip_file=page.zip
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
quality=80
if [ ! -z "$Q" ]
then
  quality="${Q}"
fi
if [ ! -z "$ZIP_FILE" ]
then
  zip_file="${ZIP_FILE}"
fi
cp head.html index.html
i=0
for f in *.JPG
do
  if [ -z "${PERC}" ]
  then
    preview="preview_${width}x${height}_${f}"
  else
    preview="preview_${PERC}perc_${f}"
  fi
  if [ ! -f "${preview}" ]
  then
    echo "generating ${preview} preview"
    if [ -z "${PERC}" ]
    then
      convert "${f}" -geometry "${width}x${height}" -quality "${quality}%" "${preview}"
    else
      convert "${f}" -geometry "${PERC}%" -quality "${quality}%" "${preview}"
    fi
  fi
  if [ -z "${PERC}" ]
  then
    echo "<a href=\"./${f}\"><img src=\"./${preview}\" alt=\"${f}\" style=\"width:${width}px;height:${height}px;\"></a>" >> index.html
  else
    echo "<a href=\"./${f}\"><img src=\"./${preview}\" alt=\"${f}\"></a>" >> index.html
  fi
  i=$((i+1))
  if [ "$i" = "$n_per_line" ]
  then
    i=0
    echo "<br />" >> index.html
  fi
done
cat tail.html >> index.html
rm -f "${ZIP_FILE}" && zip -9 "${ZIP_FILE}" make.sh *.html *.JPG && ls -l "${ZIP_FILE}"
echo 'OK'
