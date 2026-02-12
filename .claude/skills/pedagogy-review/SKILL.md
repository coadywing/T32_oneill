---
name: pedagogy-review
description: Run holistic pedagogical review on teaching materials — slides, lecture notes, assignments, or syllabi. Checks narrative arc, prerequisites, worked examples, notation clarity, and pacing.
disable-model-invocation: true
argument-hint: "[filename]"
---

# Pedagogical Review of Teaching Materials

Perform a comprehensive pedagogical review of slides, lecture notes, assignments, or other teaching content.

## Steps

1. **Identify the file** specified in `$ARGUMENTS`
   - If no argument, ask user which file to review

2. **Launch the pedagogy-reviewer agent** with the full file path
   - The agent checks 8 pedagogical patterns
   - Performs document-level analysis (narrative arc, pacing, notation)
   - Considers audience perspective — students in a course, or researchers at a seminar/conference
   - For assignments: checks clarity of instructions and expected outputs

3. **The agent produces a report** saved to:
   `quality_reports/[FILENAME_WITHOUT_EXT]_pedagogy_report.md`

4. **Present summary to user:**
   - Patterns followed vs violated (out of 8)
   - Document-level assessments
   - Critical recommendations (top 3-5)

## Important Notes

- This is a **read-only review** — no files are edited
- Focuses on **pedagogy** not code quality (use `/review-r` for R scripts)
