---
paths:
  - "code/**"
  - "manuscript/**"
  - "**/*.qmd"
---

# Task Completion Verification Protocol

**At the end of EVERY task, Claude MUST verify the output works correctly.** This is non-negotiable.

## For R Scripts:
1. Run the script with `Rscript code/script_name.r`
2. Verify output files (CSV, RDS, PNG, PDF) were created with non-zero size
3. Check for warnings or errors in output
4. Report verification results

## For LaTeX Manuscripts:
1. Compile with `latexmk -pdf` or multi-pass xelatex + biber
2. Check for compilation errors
3. Check for overfull hbox warnings
4. Verify PDF was generated
5. Report verification results

## For Quarto Slides/Documents:
1. Render with `quarto render file.qmd`
2. Verify HTML/PDF output exists
3. Check for render warnings
4. Report verification results

## For the Full Pipeline:
1. Run `Rscript code/main.r`
2. Verify all expected outputs exist in `outputs/tables/` and `outputs/figures/`
3. Check file sizes > 0

## Common Pitfalls:
- **Assuming success**: Always verify output files exist AND contain correct content
- **Relative paths**: Check that paths resolve correctly from the project root
- **Missing packages**: R scripts should handle package installation via `pacman::p_load()`

## Verification Checklist:
```
[ ] Output file created successfully
[ ] No compilation/render errors
[ ] No critical warnings
[ ] Reported results to user
```
