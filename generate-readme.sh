#!/bin/bash
#means you can run the script with a filename or if not reads `README.md` in your current directory
README="${1:-README.md}" 


# chekcs if a file named README exist or not
if [[ ! -f "$README" ]]; then
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

# first started with an empy Toc
# for each line in the headings - reads each line into the variable line, - counts how many '#' xters at the (heading level)
# and lastly title variable removes the # xter to get the heading text
toc=""
while IFS= read -r line; do
    level=$(echo "$line" | grep -o '^#\+ ' | wc -c)
    level=$((level -1))
    title=$(echo "$line" | sed 's/^#\+ //')
    anchor_link=$(echo "$title" |tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9 -]//g; s/ /-/g; s/-+/-/g')  
    toc="${toc}$(printf "%*s" $((level-1)) '')- [${title}](#${anchor_link})\n" # adds the line to the Toc with indentation and a clickable link
done <<< "$headings"     


toc_block="<!-- Table of Content -->\n${toc}" # a table content block, starting with the marker `<! -- TOC --`

if grep -q '<!-- Table of Content -->' "$README"; then # checking if there was a toc_block before
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