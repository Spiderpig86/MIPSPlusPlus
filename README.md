<h1 align="center">MIPS++</h1>
<p align="center">A lightweight framework for MIPS Assembly.</p>

### Why?
MIPS++ was designed to speed up the development process for programs written in MIPS Assembly by including common functions and macros that would otherwise end up be repeated throughout the code. This ends up decluttering the code base and increases readability. The macros and functions included are well documented and automatically preserve all registers during execution.

### Usage
MIPS++ is easy to set up for any project with only 2 additional include statements.
```assembly
.include "mpp.asm" # Include the core macros
.data
    # Your data section
.text
    # Your text section
.include "mppf.asm" # Include additional functions required by some macros
```