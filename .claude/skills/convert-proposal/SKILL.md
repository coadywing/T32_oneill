---
name: convert-proposal
description: Build the T32 grant proposal as PDF and/or Word. Supports full build, Word-only, PDF-only, or single-section Word export for collaborator review.
disable-model-invocation: true
argument-hint: "[all | pdf | word | word-section SEC=filename]"
---

# Convert T32 Grant Proposal

Build the proposal in PDF and/or Word format.

## Steps

1. **Parse the argument:**
   - `$ARGUMENTS` = `all` or empty → build both PDF and Word
   - `$ARGUMENTS` = `pdf` → build PDF only
   - `$ARGUMENTS` = `word` → build Word only
   - `$ARGUMENTS` starts with `word-section` → single section to Word (extract SEC= value)

2. **For PDF builds:**
   ```bash
   mkdir -p build
   latexmk -pdfxe -cd -outdir=build proposal/main.tex
   ```
   After success:
   - Report page count: `pdfinfo build/main.pdf | grep Pages`
   - Report file size
   - Open the PDF: `open build/main.pdf`

3. **For Word builds (full):**
   ```bash
   mkdir -p build
   pandoc \
     --from=latex \
     --to=docx \
     --reference-doc=proposal/pandoc/reference.docx \
     --bibliography=proposal/references.bib \
     --citeproc \
     --output=build/T32_proposal.docx \
     proposal/01_background.tex \
     proposal/02_program_admin.tex \
     proposal/03_program_faculty.tex \
     proposal/04_proposed_training.tex \
     proposal/05_program_evaluation.tex \
     proposal/06_trainee_candidates.tex \
     proposal/07_institutional_environment.tex \
     proposal/08_training_outcomes.tex \
     proposal/09_diversity_recruitment.tex \
     proposal/10_rcr_plan.tex \
     proposal/12_reproducibility.tex \
     proposal/11_facilities_resources.tex
   ```
   After success:
   - Report file path and size
   - Open the Word doc: `open build/T32_proposal.docx`

4. **For single-section Word builds:**
   Extract the section filename from the argument. For example, if `$ARGUMENTS` = `word-section SEC=01_background`:
   ```bash
   mkdir -p build
   pandoc \
     --from=latex \
     --to=docx \
     --reference-doc=proposal/pandoc/reference.docx \
     --bibliography=proposal/references.bib \
     --citeproc \
     --output=build/01_background.docx \
     proposal/01_background.tex
   ```

5. **Report results:**
   - PASS / FAIL for each build target
   - Output file paths and sizes
   - Any warnings or errors
   - Page count (for PDF)

6. **If a build fails:**
   - Report the error message
   - For LaTeX errors: identify the problematic file and line
   - For pandoc errors: report the conversion issue
   - Suggest likely fixes
