## Table of Contents
 - [generate-readme.sh](#generate-readmesh)
  - [Overview](#overview)
  - [Features](#features)
  - [Usage](#usage)
  - [Example](#example)
  - [How it works](#how-it-works)
  - [Author](#author)




# generate-readme.sh

## Overview

`generate-readme.sh` is a Bash script that automatically creates or updates a clickable Table of Contents (TOC) in your `README.md` file.  


## Features

- **Automatic TOC generation:** Finds all headings in your README.
- **Ignores code blocks:** Headings inside triple backtick code blocks are skipped.
- **Clickable links:** Each TOC entry links to the corresponding section.


---

## Usage

1. **Make the script executable:**
   ```bash
   chmod +x generate-readme.sh
   ```

2. **Run the script:**
   - For the `README.md` in the current directory:
     ```bash
     ./generate-readme.sh
     ```
   - For a different markdown file:
     ```bash
     ./generate-readme.sh /path/to/yourfile.md
     ```

---

## Example

Suppose your `README.md` looks like this:

```markdown
# My Project

## Introduction

## Installation

## Usage

\```
# This is a code block
## Not a real heading
\```
```

After running the script, your `README.md` will include a TOC like this:

```markdown
## Table of Content
  - [Table of Content](#table-of-content)
 - [generate-readme.sh](#generate-readmesh)
  - [Overview](#overview)
  - [Features](#features)
  - [Usage](#usage)
  - [Example](#example)
  - [How it works](#how-it-works)
  - [Author](#author)


# My Project

## Introduction

## Installation

## Usage

\```
# This is a code block
## Not a real heading
\```
```

---

## How it works

- The script looks for lines starting with `#` (for headings).
- It ignores headings inside code blocks (between triple backticks).
- It generates a markdown list with links to each heading.


---



## Author



[Arantisjr](https://github.com/Arantisjr)
