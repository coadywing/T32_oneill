# CLAUDE.md 

---

## Available Skills & Agents

| Command | What It Does |
|---------|-------------|
| `/compile-paper` | Compile LaTeX manuscript (latexmk + biber) |
| `/convert-proposal` | Build PDF and/or Word from LaTeX proposal |
| `/review-grant` | Full grant review (compliance + study section + proofread) |
| `/run-pipeline` | Run main.r and verify all outputs |
| `/proofread [filename]` | Grammar, typo, and consistency review |
| `/review-r [file]` | R code quality and reproducibility review |
| `/pedagogy-review [filename]` | Teaching material review (slides, notes, assignments) |
| `/validate-bib` | Cross-reference citations vs bibliography |
| `/devils-advocate` | Challenge design decisions |

**Agents** (for delegation): `proofreader`, `r-reviewer`, `pedagogy-reviewer`, `verifier`, `domain-reviewer`, `slide-auditor`, `t32-compliance-checker`, `nih-study-section-reviewer`

**Rules** (auto-loaded): See `.claude/rules/` for workflow, R code, quality gates, and verification protocols.

---

## Project Overview

The O'Neill School of Public and Environmental Affairs at Indiana University Bloomington is proposing to host an NIA T32 Institutional Training Grant to prepare pre-doctoral students and post-doctoral fellows for research careers in health economics and policy affecting older adults. 

The program addresses NIA's strategic priorities by training researchers to apply rigorous econometric methods to critical questions about Medicare and Medicaid policy, long-term care financing, dementia caregiving, and healthcare access for aging populations. The main task is to write the proposal

---

## Coding Preferences

### R Package Philosophy

Take a **minimalist but sensible** approach to packages:

- **data.table** — Primary tool for data wrangling. Strongly preferred over tidyverse.
- **fixest** — Regression analysis (`feols`, etc.).
- **ggplot2** — Visualization.
- **here** — All file paths. Never `setwd()`, never absolute paths.
- **pacman** — Package management via `p_load()`.

Avoid elaborate tidyverse pipelines. data.table syntax is preferred for most data manipulation.

### Code Style

- **Prefer explicitness** for core operations. It should be easy to see exactly where a regression gets run or a figure gets made.
- **Use functions and loops when warranted** — when you'd otherwise write 20+ nearly identical lines.
- **Avoid premature abstraction.** Three similar lines of code is often better than a function that obscures what's happening.
- **Separate plot creation from saving:**
  ```r
  p <- ggplot(data, aes(x, y)) + geom_point()
  ggsave(here("outputs", "figures", "plot.png"), p, width = 10, height = 8)
  ```
- **Titles on plots:** Include titles by default. When a plot is destined for a LaTeX figure, omit the title (let `\caption{}` handle it) — but keep the title in the R code as a comment so it's easy to toggle back.
- **Snake_case** for everything. Descriptive names: `tot_spend_per_100`, `adoption_year_quarter`.
- **message()** for completion messages. Never `cat()` or `print()` for status.
- **Script headers** with project, script name, inputs, outputs.
- **Section separators:** `# Section name -------`

---

## Project Structure

### Research Project Layout

```
project/
├── CLAUDE.md                    # This file
├── .claude/                     # Workflow config (agents, rules, skills)
├── code/
│   ├── main.r                   # Run this to reproduce all results
│   ├── 01_clean_source1.r
│   ├── 02_clean_source2.r
│   ├── 03_make_panel.r
│   ├── 04_estimation.r
│   ├── 05_figures.r
│   └── 06_export_results_tex.r
├── raw_data/                    # NOT in git (users add manually)
├── temp_data/                   # NOT in git (intermediate datasets)
├── outputs/
│   ├── tables/                  # Regression tables, LaTeX macros
│   │   └── result_numbers.tex   # Inline result macros (from R)
│   └── figures/                 # Plots (PNG)
├── manuscript/
│   ├── main.tex                 # Master document (compile from project root)
│   ├── 0_abstract.tex
│   ├── 1_introduction.tex
│   ├── 2_data.tex
│   ├── 3_methods.tex
│   ├── 4_results.tex
│   ├── 5_discussion.tex
│   ├── 6_exhibits.tex
│   ├── 7_appendix.tex
│   ├── references.bib
│   ├── preamble_code/
│   │   ├── paper.sty            # Document style (fonts, layout, biblatex)
│   │   └── math.sty             # Math macros (brackets, operators, stats)
│   └── figure_code/             # Standalone figure layout .tex files
├── literature/                    # Background reading (PDFs of key references)
├── quality_reports/
│   ├── plans/                   # Saved implementation plans
│   └── session_logs/            # Session history
├── .gitignore
├── README.md
├── lab_journal.md               # NOT in git (session-by-session notes)
└── project_name.Rproj
```

**Compilation:** Run `latexmk -pdf manuscript/main.tex` from the **project root**. All paths in main.tex are relative to root (e.g., `outputs/tables/`, `manuscript/1_introduction`).

### Teaching Project Layout

```
project/
├── CLAUDE.md
├── .claude/
├── slides/                      # Quarto RevealJS slides
│   ├── lecture01_topic.qmd
│   └── theme.scss
├── notes/                       # Lecture notes, handouts
├── assignments/                 # Problem sets, exams
├── syllabus/
├── code/                        # R scripts for examples/demos
├── data/                        # Teaching datasets
├── quality_reports/
├── .gitignore
├── README.md
└── lab_journal.md
```

Adapt the layout to your project. Delete directories you don't need.

---

## Working Philosophy

### Plan-First Approach

For any non-trivial task, Claude enters **plan mode first**:

1. **Plan** — draft approach, list files to modify, identify risks
2. **Save** — write plan to `quality_reports/plans/` (survives context compression)
3. **Review** — present plan and wait for approval
4. **Implement** — orchestrator takes over

See `.claude/rules/plan-first-workflow.md` for the full protocol.

### Contractor Mode (Orchestrator)

After plan approval, Claude autonomously: implement, verify, review with agents, fix issues, re-verify, score. See `.claude/rules/orchestrator-protocol.md`.

### Quality Gates

| Threshold | When | Meaning |
|-----------|------|---------|
| **80/100** | Commit | Good enough to save progress |
| **90/100** | PR | Ready for deployment |
| **95/100** | Excellence | Aspirational target |

### Continuous Learning

When Claude makes a mistake, tag the correction:
```
[LEARN:r-code] fread silently drops rows when ... → use ...
[LEARN:citation] Post-LASSO is Belloni (2013), NOT Belloni (2014)
```
These persist in MEMORY.md and prevent recurring mistakes.

> **Never use `/clear`.** Rely on auto-compression to manage long conversations.

---

## Reproducibility

Every project has a `main.r` that reproduces all results:

```r
library(here)
source(here("code", "01_clean_data.r"))
source(here("code", "02_make_panel.r"))
source(here("code", "03_estimation.r"))
source(here("code", "04_figures.r"))
```

**Path rules:** Always `here()`. Never `setwd()`. Never hardcode absolute paths.

---

## What Goes in Git

- **Commit:** code, outputs (tables/figures), manuscript, documentation, .Rproj
- **Do NOT commit:** raw_data/, temp_data/, literature/, lab_journal.md, .Rhistory, .RData

---

## Lab Journal

Maintain `lab_journal.md` in the project root (gitignored). Update at the end of each session:
- What was accomplished
- Issues encountered
- Next steps or open questions

---

## Session Rituals

**Start each session:**
1. Read CLAUDE.md
2. Check recent git commits
3. Check `quality_reports/plans/` for in-progress plans
4. Check `quality_reports/session_logs/` for recent session logs
5. State what you understand the current task to be

**End each session:**
1. Save session log to `quality_reports/session_logs/`
2. Commit significant changes
3. Note unresolved questions

---

## Reminders for Claude

- Read existing code before proposing changes
- Keep changes focused on what was requested
- Prefer editing existing files over creating new ones
- Use data.table syntax by default
- Ensure all file paths use `here()`
- After significant work, update `lab_journal.md`
