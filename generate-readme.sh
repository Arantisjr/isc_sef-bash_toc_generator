#!/bin/bash
#means you can run the script with a filename or if not reads `README.md` in your current directory
README="${1:-README.md}" 


# chekcs if a file named README exist or not
if [[ ! -f "$README"]]; then
    echo "README file not found: $README"
    exit 1
fi

# a variable called heading, awk command proceses 
# the file line by line
# before reading the file set a variable code block to zero
# then check if the line starts with 3x` toogle code_block(that is enters or exits a code block)
# and if !code_blocj(not inside a code block) and line starts with 1-6 # followed by a space print the ;one its a heading

headings=$(
    awk '
    BEGIN {code_block=0}
    /^```/ { code_block = !code_block; next }
    !code_block && /^#{1,6} / { print }
    
    ' "$README"
)

# checks if the h.. varian;e is empty and stops the script
if [[ -z "$headings" ]]; then
    echo "No headings found."
    exit 0
fi

toc=""
while IFS= read -r line; do
    level=$(echo "$line" | grep -o '^#\+ ' | wc -c)
    level=$((level -1))
    title=$(echo "$line" | sed 's/^#\+ //')
    anchor_link=$(echo "$title" |tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9 -]//g; s/ /-/g; s/-+/-/g')  
    toc="${toc}$(printf "%*s" $((level-1)) '')- [${title}](#${anchor})\n"
done <<< "$headings"     


toc_block="<!-- TOC -->\n${toc}"

if grep -q '<!-- TOC -->' "$README"; then
  # Replace existing TOC block
  awk -v toc_block="$toc_block" '
    BEGIN { in_toc=0 }
    /<!-- TOC -->/ {
      print toc_block
      in_toc=1
      next
    }
    in_toc && /^-/ { next }
    in_toc && NF==0 { in_toc=0 }
    !in_toc { print }
  ' "$README" > "${README}.tmp"
else
  # Insert TOC at the top
  echo -e "$toc_block\n" | cat - "$README" > "${README}.tmp"
fi

mv "${README}.tmp" "$README"
echo "Table of Contents updated in $README"