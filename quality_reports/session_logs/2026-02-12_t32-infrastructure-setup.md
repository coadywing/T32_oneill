# Session Log: T32 Infrastructure Setup

**Date:** 2026-02-12
**Task:** Set up LaTeX, pandoc, agents, and skills for NIA T32 proposal

## What Was Accomplished

### Part 1: Reference Documents
- Created `literature/PA-25-168_T32_summary.md` — comprehensive FOA summary with all sections, page limits, review criteria, budget rules, and formatting requirements (sourced from NIH website)
- Created `.claude/rules/nih-formatting.md` — machine-readable formatting rules for agents/skills

### Part 2: LaTeX Infrastructure
- Created `proposal/` directory with full T32 section structure (12 .tex files)
- Created `proposal/preamble_code/nih-t32.sty` — NIH-compliant style (Arial 11pt, 0.5in margins, 15pt spacing, no headers/footers)
- Created `proposal/main.tex` — master document with conditional compilation toggles
- All section stubs have TODO comments describing required content per the FOA

### Part 3: Pandoc Workflow
- Created `proposal/pandoc/Makefile` with targets: pdf, word, word-section, pages, clean
- Created `proposal/pandoc/reference.docx` — Word template with NIH fonts/margins (generated via pandoc + python-docx styling)
- Verified: both PDF and Word builds work successfully

### Part 4: Custom Agents
- Created `.claude/agents/t32-compliance-checker.md` — checks section completeness, page limits, required content elements, formatting
- Created `.claude/agents/nih-study-section-reviewer.md` — simulates study section review with 5 scored criteria (1-9 scale)

### Part 5: Custom Skills
- Created `.claude/skills/convert-proposal/SKILL.md` — `/convert-proposal` skill (pdf, word, word-section, all)
- Created `.claude/skills/review-grant/SKILL.md` — `/review-grant` skill (orchestrates compliance + review + proofread)

### Part 6: Configuration
- Updated `CLAUDE.md` — added new skills and agents to the table
- Updated `.claude/settings.json` — added pandoc, make, pdfinfo to allowed commands
- Updated `.gitignore` — added `build/` and proposal build artifacts

## Verification Results
- `latexmk -pdfxe proposal/main.tex` — PASS (6 pages, 34KB)
- `pandoc → build/T32_proposal.docx` — PASS (11KB)
- All 17 new files created and accounted for

## Design Decisions
- Used `xelatex` (via `-pdfxe`) instead of `pdflatex` because the style file uses `fontspec` for Arial font support
- Used `natbib` for citations (standard in NIH grant world) rather than `biblatex`
- Kept `manuscript/` directory untouched — it's from the project template
- Build output goes to `build/` at project root (gitignored)
- `pdfinfo` not installed on this machine — page counts via Python fallback or `mdls`

## Notes
- The Makefile uses paths relative to `proposal/pandoc/` — run with `make -C proposal/pandoc`
- The `/convert-proposal` skill uses project-root-relative commands (no Makefile dependency)
- Reference.docx was styled programmatically with python-docx — may need manual polish for final submission
- NIA submission date: May 25 (next cycle)

## Open Questions
- Should we install `poppler` for `pdfinfo` command? Would enable automatic page-count checking in the Makefile
- The plan mentioned a `proposal/supporting_docs/` directory for biosketches and letters — not created yet (defer until needed)
