#!/bin/bash

echo "Before import index. Normalize."
cd /tmp/
for i in `ls *.json`;
  do
    echo "$i";
    tmpname=`basename $i .json`
    IS_ARRAY=` head -1 "${tmpname}.json" | grep -e '^\[' | wc -l`
    if [ $IS_ARRAY -eq 0 ]; 
      then
        jq -c '.' "${tmpname}.json"> "${tmpname}_tmp.json"
      else
        jq -c '.[]' "${tmpname}.json"> "${tmpname}_tmp.json"
    fi
    ID=1 && cat "${tmpname}_tmp.json" | while read LINE; do echo "{\"index\":{\"_id\":\"$ID\"}}"; echo $LINE; let "ID+=1"; done >"${tmpname}.json"
    rm "${tmpname}_tmp.json"
  done

#start import json file
ES_CONNECT=`curl -s -o /dev/null -I -w "%{http_code}" ${ESDOMAIN}:${ESPORT}`
if [ $ES_CONNECT -eq 200 ]; 
  then 
    for INDEX in `ls *.json`;
      do
        INDEX=`basename $INDEX .json`;
        curl -H 'Content-Type: application/x-ndjson' -XPUT "${ESDOMAIN}:${ESPORT}/${INDEX}/doc/_bulk?pretty" --data-binary @${INDEX}.json
      done
  else
  echo "ES не отвечает... Проверить сетевую связанность"
fi
