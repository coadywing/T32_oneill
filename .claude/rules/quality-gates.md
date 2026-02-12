---
paths:
  - "code/**/*.r"
  - "code/**/*.R"
  - "manuscript/**/*.tex"
  - "**/*.qmd"
---

# Quality Gates & Scoring Rubrics

**Purpose:** Define objective quality thresholds for committing and deploying project materials.

---

## Scoring System

- **80/100 = Commit threshold** — Good enough to save progress
- **90/100 = PR threshold** — High quality ready for deployment
- **95/100 = Excellence** — Aspirational target

---

## R Scripts (.r files)

### Critical (Must Pass for Commit)
| Issue | Deduction |
|-------|-----------|
| Syntax errors / script fails to run | -100 (auto-fail) |
| Known domain-specific bugs | -30 |
| Hardcoded absolute paths or `setwd()` | -20 |
| Wrong estimand or incorrect formula | -20 |

### Major (Should Pass for PR)
| Issue | Deduction |
|-------|-----------|
| Missing `set.seed()` when randomness is used | -10 |
| Missing script header (project, inputs, outputs) | -5 |
| `cat()` or `print()` for status messages | -5 per instance |
| tidyverse where data.table is more appropriate | -3 per instance |

### Minor (Nice-to-Have)
| Issue | Deduction |
|-------|-----------|
| Missing section separators | -1 |
| Inconsistent variable naming | -1 per instance |

---

## LaTeX Manuscripts (.tex files)

### Critical
| Issue | Deduction |
|-------|-----------|
| Compilation failure | -100 (auto-fail) |
| Undefined citation | -15 per citation |
| Overfull hbox > 10pt | -10 per instance |

### Major
| Issue | Deduction |
|-------|-----------|
| Missing cross-reference | -5 per instance |
| Inconsistent notation | -3 per occurrence |
| Grammar error in formal writing | -3 per instance |

---

## Quarto Slides (.qmd files)

### Critical
| Issue | Deduction |
|-------|-----------|
| Render failure | -100 (auto-fail) |
| Broken citation | -15 per citation |

### Major
| Issue | Deduction |
|-------|-----------|
| Content overflow (text beyond slide boundary) | -5 per instance |
| Notation inconsistency | -3 per occurrence |

### Minor
| Issue | Deduction |
|-------|-----------|
| Font size reduction used | -1 per slide |

---

## Quality Gate Enforcement

### Commit Gate (score < 80)
Block commit. List blocking issues with required actions.

### PR Gate (score < 90)
Allow commit but warn. List issues with recommendations to reach PR quality.

### User can override with justification when needed.
