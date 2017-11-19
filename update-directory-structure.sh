#!/bin/bash

# Generate md5 checksum for every .zip file
 for ZIP in $(find . -name '*.zip'); do
   (
   md5sum ${ZIP} | grep -o '^\S*' > ${ZIP}.md5
   )
done

# Update addons.xml md5 checksum
md5sum addons.xml | grep -o '^\S*' > addons.xml.md5

# Generate index.html files
for DIR in $(find . -type d); do
  (
  echo -e "<html>\n<body>\n<h1>Directory listing</h1>\n<hr/>\n<pre>"
  ls -1pa "${DIR}" | grep -v "^\./$" | grep -v "^index\.html$"  | awk '{ printf "<a href=\"%s\">%s</a>\n",$1,$1 }'
  echo -e "</pre>\n</body>\n</html>"
  ) > "${DIR}/index.html"
done
