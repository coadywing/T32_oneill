---
name: compile-paper
description: Compile the LaTeX manuscript. Runs latexmk (or multi-pass pdflatex + biber) from the project root and reports errors, warnings, and undefined references.
disable-model-invocation: true
argument-hint: "[optional: path to main.tex]"
---

# Compile LaTeX Manuscript

Compile the LaTeX paper and report any issues.

## Steps

1. **Locate the manuscript:**
   - If `$ARGUMENTS` specifies a file: use that
   - Otherwise: use `manuscript/main.tex`

2. **Compile from the project root using latexmk** (preferred):
   ```bash
   latexmk -pdf manuscript/main.tex
   ```
   If latexmk is not available, use multi-pass compilation:
   ```bash
   pdflatex -interaction=nonstopmode manuscript/main.tex && biber main && pdflatex -interaction=nonstopmode manuscript/main.tex && pdflatex -interaction=nonstopmode manuscript/main.tex
   ```

3. **Check for issues:**
   - Compilation errors (exit code != 0)
   - Overfull hbox warnings (count them)
   - Undefined citations or references
   - Missing files or packages

4. **Verify output:**
   - Confirm PDF was generated (`main.pdf` in project root)
   - Report file size
   - Open the PDF for visual inspection: `open main.pdf`

5. **Report results** to the user:
   - PASS / FAIL with details
   - Count of warnings by type
   - Any undefined references listed
