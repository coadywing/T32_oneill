# Plan: T32 Grant Infrastructure — LaTeX, Pandoc Workflow, and Custom Agents

**Date:** 2026-02-12
**Status:** COMPLETED
**Task:** Set up LaTeX infrastructure for NIH T32 grant proposal (PA-25-168) with pandoc Word conversion, plus build three custom agents/skills for grant writing.

## Context

The O'Neill School is preparing an NIA T32 proposal. The project currently has a generic research-paper LaTeX template in `manuscript/`. We need to:
1. Create NIH-compliant LaTeX infrastructure specific to T32 proposals in a new `proposal/` directory
2. Set up a LaTeX → Word pandoc pipeline for collaborator review
3. Build three new agents: pandoc translator, NIH study section reviewer, T32 compliance checker
4. Save the RFP and formatting rules as reference documents in `literature/`

**Existing assets:** Pandoc 3.8.3 installed. Existing agent/skill patterns in `.claude/`. Draft Word docs at project root (NIA_T32_DraftJan30.docx, Abstract_and_PHR_Statement.docx).

---

## Part 1: LaTeX Infrastructure

### 1a. Create `proposal/` directory with T32-specific sections

```
proposal/
├── main.tex                        # Master document (compile target)
├── preamble_code/
│   └── nih-t32.sty                 # NIH-compliant formatting
├── 00_specific_aims.tex            # 1 page (separate attachment)
├── 01_background.tex               # Part of 25-page Program Plan
├── 02_program_admin.tex            #   "
├── 03_program_faculty.tex          #   "
├── 04_proposed_training.tex        #   "
├── 05_program_evaluation.tex       #   "
├── 06_trainee_candidates.tex       #   "
├── 07_institutional_environment.tex#   "
├── 08_training_outcomes.tex        #   "
├── 09_diversity_recruitment.tex    # 3 pages (separate attachment, new as of Jan 2025)
├── 10_rcr_plan.tex                 # 3 pages (separate attachment)
├── 11_facilities_resources.tex     # No page limit
├── references.bib
└── pandoc/
    ├── reference.docx              # Word styling template (NIH fonts/margins)
    └── Makefile                    # Build targets: pdf, word, clean
```

### 1b. Create `nih-t32.sty` — NIH-compliant style file

Key formatting rules from NIH:
- **Font:** 11pt Arial (NIH recommended; Georgia/Helvetica/Palatino also acceptable)
- **Margins:** 0.5 inches all sides (NIH minimum)
- **Line spacing:** ~15pt (stays within NIH's "no more than 6 lines per inch")
- **No headers/footers** (NIH adds them on submission)
- **No page numbers** (NIH adds them)
- **Letter paper** (8.5" x 11")
- Clean, minimal design — no decorative elements

### 1c. Create `main.tex` — grant master document

Mirrors the T32 section structure. Uses `\input{}` for each section.

### 1d. Create pandoc Makefile

Build targets:
- `make pdf` → latexmk → proposal PDF (submission-ready)
- `make word` → pandoc → .docx with NIH formatting (for collaborators)
- `make word-section SEC=01_background` → single-section Word export
- `make clean` → remove build artifacts
- `make pages` → compile and report page count per section

---

## Part 2: Reference Documents

### 2a. Save RFP summary to `literature/PA-25-168_T32_summary.md`

Structured summary covering: required sections, page limits, review criteria, NIA priorities, budget rules, formatting, deadlines.

### 2b. Save NIH formatting rules to `.claude/rules/nih-formatting.md`

Formatting requirements that agents reference when checking compliance.

---

## Part 3: Custom Agents and Skills

### 3a. `/convert-proposal` (Skill)

Pandoc conversion skill. Accepts: `all`, `word`, `pdf`, or a section filename. Runs pandoc with `--reference-doc`, `--citeproc`, `--bibliography`.

### 3b. `nih-study-section-reviewer` (Agent)

Simulates T32 study section review using 5 scored criteria:
1. Training Program and Environment
2. Training PD/PI(s)
3. Preceptors/Mentors
4. Trainees
5. Training Record

Output: Strengths/Weaknesses per criterion, scores (1-9), overall impact score.

### 3c. `t32-compliance-checker` (Agent)

Checks: section completeness, page limits, required content elements, formatting compliance. Output: PASS/FAIL checklist.

### 3d. `/review-grant` (Skill)

Orchestrates: compliance checker + study section reviewer + proofreader. Produces aggregate report.

---

## Part 4: Configuration Updates

- Update `CLAUDE.md` available skills table
- Update `.claude/settings.json` with pandoc permissions

---

## Implementation Order

1. Reference docs (literature + rules)
2. LaTeX infrastructure (sty, main.tex, section stubs, Makefile)
3. Pandoc reference.docx
4. Agents (compliance, then study section)
5. Skills (convert-proposal, then review-grant)
6. Configuration updates

## Verification

- [ ] `latexmk -pdf proposal/main.tex` compiles cleanly
- [ ] `make -C proposal/pandoc word` produces a .docx with correct formatting
- [ ] `/convert-proposal all` runs without error
- [ ] `/review-grant` runs the agent pipeline on the stub files
- [ ] All new agents produce properly formatted reports
