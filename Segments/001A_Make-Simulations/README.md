# Building Student and Instructor Guides

To build the `instructor.pdf` file, you need to have typst and pandoc installed.

```bash
pandoc -o instructor.pdf --pdf-engine=typst --template=../nei-style/mdstyle.typ instructor.md
```
