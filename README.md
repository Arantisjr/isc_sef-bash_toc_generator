# generate-readme.sh

## Overview

`generate-readme.sh` is a Bash script that automatically creates or updates a clickable Table of Contents (TOC) in your `README.md` file.  
It scans for headings (like `#`, `##`, etc.), ignores headings inside code blocks, and inserts or updates a TOC at the `<!-- TOC -->` marker in your README.

---

## Features

- **Automatic TOC generation:** Finds all headings in your README.
- **Ignores code blocks:** Headings inside triple backtick code blocks are skipped.
- **Clickable links:** Each TOC entry links to the corresponding section.
- **Smart updating:** If a TOC already exists at `<!-- TOC -->`, it is replaced with the new one.
- **Custom file support:** You can specify a different markdown file if needed.

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
<!-- TOC -->
- [My Project](#my-project)
- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)

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
- It inserts or updates the TOC at the `<!-- TOC -->` marker.

---



## Author

[Arantisjr](https://github.com/Arantisjr)