# coady-claude-workflow

A template repository for using [Claude Code](https://docs.anthropic.com/en/docs/claude-code) to support empirical research and teaching. Clone it to start a new project with a pre-configured set of agents, review skills, coding conventions, and quality gates.

*Credits* -- I started with Pedro H. C. Sant'Anna's workflow and then added and changed things from there. You can find his setup here: [pedrohcgs/claude-code-my-workflow](https://github.com/pedrohcgs/claude-code-my-workflow).

---

## What's in the box

| Component | What it does |
|-----------|-------------|
| `CLAUDE.md` | Project guide that Claude reads at session start — coding preferences, project structure, workflow rules. You should customize it to fit your preferences. |
| 6 agents | Specialized reviewers: `proofreader`, `r-reviewer`, `domain-reviewer`, `pedagogy-reviewer`, `slide-auditor`, `verifier` |
| 7 skills | Slash commands: `/proofread`, `/review-r`, `/compile-paper`, `/run-pipeline`, `/pedagogy-review`, `/validate-bib`, `/devils-advocate` |
| 9 rules | Auto-loaded conventions for R code, quality gates, plan-first workflow, orchestrator protocol, proofreading, verification, and more |
| Skeleton Directory Structure | `code/`, `raw_data/`, `temp_data/`, `outputs/`, `manuscript/`, `quality_reports/` |

---

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 
- R (for statistical computing and data manipulation)
- LaTeX Distribution (for manuscripts) 
- Quarto (for slides and teaching documents)
- Git and GitHub CLI (`gh`)

---

## Getting started

### 1. Create a new project from the template

Open this repo in GitHub and click **Use this template**. 

Or use the command line to clone the repo: 

```bash
gh repo create my-new-project --template coadywing/coady-claude-workflow --private --clone
cd my-new-project
```

### 2. Open the project

To make sure `here()` paths work correctly, open the project the right way:

- **RStudio:** Double-click the `.Rproj` file (e.g., `coady-claude-workflow.Rproj`). This sets the working directory to the project root automatically.
- **VS Code:** Open the project folder (`File → Open Folder…`). The `.Rproj` file at the root tells `here()` where it is.

Either method anchors `here()` to the project root so all file paths resolve correctly.

### 3. Customize CLAUDE.md

Open `CLAUDE.md` and fill in the placeholders at the top:

- Project name and description
- Project type (research or teaching)
- Delete directory sections you don't need (e.g., `manuscript/` for a teaching project, `slides/` for a research project)

### 4. Set up data and directories

```bash
# For research projects — put your raw data in place
cp /path/to/your/data.csv raw_data/

# For teaching — create your slide directory
mkdir -p slides
```

### 5. Start Claude Code

```bash
claude
```

Claude reads `CLAUDE.md` on startup and knows your project structure, coding conventions, and available tools. You're ready to go.

---

## Use Case 1: Research project

You have data. You want to clean it, run regressions, make figures, and write a paper.

### Typical first session

```
You: I have two data sources in raw_data/ — enrollment.csv and claims.csv.
     We need to clean these two data sets and merge on member_id and year to create an analysis panel. Eventually, we will fit diff-in-diff regressions. My rough notes on the project are in notes/project_notes.md.

Claude: [enters plan mode, drafts a step-by-step plan, asks for approval]

You: Looks good, go ahead.

Claude: [creates 01_clean_enrollment.r, 02_clean_claims.r, 03_make_panel.r,
         04_estimation.r, 05_figures.r, and main.r — runs the pipeline,
         verifies outputs, runs /review-r, fixes issues]
```

### Common commands during a research session

```
You: Run the pipeline and make sure everything still works.
     → Claude runs main.r, checks that all outputs exist

You: Add state fixed effects to the main specification.
     → Claude modifies the estimation script, re-runs, compares results

You: /review-r 04_estimation.r
     → Launches the R code reviewer — checks data.table conventions,
        reproducibility, domain correctness, figure quality

You: /compile-paper
     → Compiles the LaTeX manuscript, reports errors and warnings

You: Write up the main results in the paper. The point estimates and
     standard errors should come from the R output, not be hardcoded.
     → Claude creates LaTeX \newcommand macros from R output and
        references them in the manuscript text

You: /proofread manuscript/3_results.tex
     → Runs the proofreader on the results section

You: /validate-bib
     → Cross-checks all \citet{} and \citep{} keys against references.bib
```

### End of session

```
You: Let's wrap up. Commit what we have.
     → Claude commits with a descriptive message, updates lab_journal.md
```

### Next session

```
You: [starts claude]

Claude: [reads CLAUDE.md, checks git log, reads recent session log,
         picks up where you left off]
```

---

## Use Case 2: Teaching project

You're building lecture slides, assignments, or course materials.

### Typical first session

```
You: I'm teaching a graduate econometrics course. I need to create
     Quarto RevealJS slides for a lecture on instrumental variables. I made some initial notes on what I want in notes/iv_notes.qmd. The idea is to start with motivation, then the formal setup, then a worked example with simulated data.

Claude: [enters plan mode — outlines slide structure, proposes
         an R simulation for the worked example, asks for approval]

You: Looks good. Make sure the slides aren't too dense.

Claude: [creates slides/lecture05_iv.qmd with motivation, definitions,
         worked example with R code chunks, renders to verify]
```

### Common commands during a teaching session

```
You: The notation slide has too much on it. Split it up.
     → Claude splits the slide, builds notation incrementally

You: /proofread slides/lecture05_iv.qmd
     → Checks grammar, typos, citation format, and consistency

You: /pedagogy-review slides/lecture05_iv.qmd
     → Reviews narrative arc, pacing, whether examples follow
        definitions, notation clarity, engagement moments

You: /devils-advocate slides/lecture05_iv.qmd
     → Challenges the slide design: "Could students understand
        this better if we showed X before Y?"

You: Create a problem set on IV estimation. Three problems,
     increasing difficulty. Include an empirical exercise
     using the simulated data from the lecture.
     → Claude creates assignments/ps05_iv.qmd

You: I need to present this paper at a seminar next week.
     Can you help me build slides that tell the story clearly
     for a non-specialist audience?
     → Claude drafts seminar slides, runs pedagogy-reviewer
        with seminar-audience lens
```

---

## Available slash commands

| Command | What it does |
|---------|-------------|
| `/compile-paper` | Compile LaTeX manuscript (latexmk + biber) |
| `/run-pipeline` | Run `main.r` and verify all outputs |
| `/proofread [file]` | Grammar, typos, consistency, overflow |
| `/review-r [file]` | R code quality, reproducibility, conventions |
| `/pedagogy-review [file]` | Narrative arc, pacing, notation, examples |
| `/validate-bib` | Cross-check citations vs bibliography |
| `/devils-advocate [file]` | Challenge content with pedagogical questions |

---

## Review agents

These run automatically during the orchestrator loop or can be invoked via skills:

| Agent | Reviews | Triggered by |
|-------|---------|-------------|
| `proofreader` | Grammar, typos, overflow, citations | `.tex`, `.qmd`, `.md` files |
| `r-reviewer` | Code quality, data.table, figures, reproducibility | `.r` / `.R` files |
| `slide-auditor` | Slide overflow, font sizing, spacing, visual rhythm | `.qmd` slide files |
| `pedagogy-reviewer` | Narrative arc, pacing, notation, audience engagement | Teaching and seminar materials |
| `domain-reviewer` | Substantive correctness — assumptions, derivations, citations | Domain-critical content |
| `verifier` | Compilation, rendering, output existence | All file types |

---

## Project structure

Adapt to your needs. Delete what you don't use.

```
project/
├── CLAUDE.md                    # Claude reads this first
├── .claude/                     # Agents, rules, skills, settings
├── code/
│   ├── main.r                   # Reproduces all results
│   ├── 01_clean_data.r
│   └── ...
├── raw_data/                    # NOT in git
├── temp_data/                   # NOT in git
├── outputs/
│   ├── tables/
│   └── figures/
├── manuscript/                  # LaTeX paper
│   ├── main.tex
│   └── references.bib
├── slides/                      # Quarto RevealJS (teaching)
├── quality_reports/             # Auto-generated plans, logs, reviews
├── .gitignore
├── README.md
├── project-name.Rproj           # Open this in RStudio
└── lab_journal.md               # NOT in git
```

---

## Coding conventions (summary)

- **data.table** for data manipulation (not tidyverse)
- **here()** for all paths (never `setwd()`, never absolute paths)
- **pacman::p_load()** for packages
- **fixest** for regressions
- **ggplot2** for figures — separate creation from `ggsave()`, include titles by default (omit for LaTeX figures)
- **Explicit code** over abstraction — functions only when they prevent dangerous repetition
- **message()** for status — never `cat()` or `print()`
- **Snake_case** everywhere

Full details in `.claude/rules/r-code-conventions.md`.

