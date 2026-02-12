---
name: run-pipeline
description: Run the main.r pipeline and verify all outputs exist with non-zero size. Use to check that the full analysis reproduces correctly.
disable-model-invocation: true
argument-hint: "[optional: specific script to run]"
---

# Run the R Analysis Pipeline

Run the project's R pipeline and verify outputs.

## Steps

1. **Identify what to run:**
   - If `$ARGUMENTS` specifies a script: run that script only
   - Otherwise: run `code/main.r` (the full pipeline)

2. **Execute the pipeline:**
   ```bash
   Rscript code/main.r
   ```
   Or for a specific script:
   ```bash
   Rscript code/$ARGUMENTS
   ```

3. **Verify outputs exist:**
   - Check `outputs/tables/` for expected table files (CSV, tex)
   - Check `outputs/figures/` for expected figure files (PNG, PDF)
   - Check `temp_data/` for intermediate datasets
   - Verify all output files have non-zero size

4. **Report results:**
   - Script exit code (0 = success)
   - List of output files created/updated with sizes
   - Any warnings or errors from R
   - Any missing expected outputs

5. **If the pipeline fails:**
   - Report the error message
   - Identify which script in the pipeline failed
   - Suggest likely causes
