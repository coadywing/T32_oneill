---
name: review-grant
description: Full grant review pipeline — runs compliance checker, study section reviewer, and proofreader on the T32 proposal. Aggregates all results into a single summary report.
disable-model-invocation: true
argument-hint: "[optional: compliance | review | proofread — run only one stage]"
---

# Full Grant Review

Orchestrate a comprehensive review of the T32 grant proposal.

## Steps

1. **Parse the argument:**
   - `$ARGUMENTS` = empty or `all` → run all three stages
   - `$ARGUMENTS` = `compliance` → run only compliance checker
   - `$ARGUMENTS` = `review` → run only study section reviewer
   - `$ARGUMENTS` = `proofread` → run only proofreader on all .tex files

2. **Stage 1: Compliance Check**
   Run the `t32-compliance-checker` agent on the proposal.
   - This checks section completeness, page limits, required content elements, and formatting
   - Output: `quality_reports/t32_compliance_report.md`

3. **Stage 2: Study Section Review**
   Run the `nih-study-section-reviewer` agent on the proposal.
   - This simulates a T32 study section review with scores and critique
   - Output: `quality_reports/study_section_review.md`

4. **Stage 3: Proofreading**
   Run the `proofreader` agent on all `.tex` files in `proposal/`.
   - Check each section file for grammar, typos, consistency, and academic quality
   - Output: `quality_reports/proposal_proofread_report.md`

5. **Aggregate Results**
   After all stages complete, create a summary report at `quality_reports/grant_review_summary.md`:

   ```markdown
   # Grant Review Summary

   **Date:** [YYYY-MM-DD]
   **Stages Run:** [list]

   ## Compliance
   - **Status:** PASS / FAIL / PASS WITH WARNINGS
   - **Critical Issues:** [count and summary]
   - **Warnings:** [count]

   ## Study Section Review
   - **Overall Impact Score:** [N]/9
   - **Criterion Scores:** [list each]
   - **Top Strengths:** [top 3]
   - **Top Weaknesses:** [top 3]

   ## Proofreading
   - **Issues Found:** [count by severity]
   - **High Priority:** [list]

   ## Recommended Actions (Priority Order)
   1. [Most critical action]
   2. [Next action]
   3. ...
   ```

6. **Report to user:**
   - Summary of findings across all three stages
   - Paths to all generated reports
   - Recommended next steps in priority order
