#!/bin/bash
# pass one or more folders as arguments
while true; do
  for f in "$@"; do
    date
    echo "Checking $f and subfolders"
    find=$(find "$f" -type f)
    while read -r f2; do
      # strip non-alphanumeric from filename for a variable var name
      v=${f2//[^[:alpha:]]/}
      r=$(md5sum "$f2")
      if [ "$r" != "${!v}" ]; then
        eval "chmod 0777 -R $@"
        echo "Applied Permissions $@"
      fi
      eval "${v}=\$r"
    done <<< "$find"
  done
done
