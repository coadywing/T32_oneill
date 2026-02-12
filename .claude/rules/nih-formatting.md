# NIH T32 Formatting and Structure Rules

These rules govern all proposal documents in the `proposal/` directory.

**Important:** T32 training grants differ from R01 research grants. There is NO separate
Specific Aims page. Program goals and objectives open the Research Training Program Plan.

---

## Formatting Requirements (Enforced in nih-t32.sty)

| Parameter | Value | Source |
|-----------|-------|--------|
| Font | 11pt Arial (NIH recommended) | PA-25-168, NIH Format Guide |
| Margins | 0.5 inches all sides | NIH Format Guide |
| Line spacing | ~15pt (stays within 6 lines/inch rule) | NIH Format Guide |
| Character density | ≤15 characters per linear inch | NIH Format Guide |
| Page size | Letter (8.5" × 11") | NIH Format Guide |
| Headers/footers | None (NIH adds them) | NIH Format Guide |
| Page numbers | None (NIH adds them) | NIH Format Guide |
| Color | Black text; color in figures OK | NIH Format Guide |

## T32 Section Structure and Page Limits

### 25-Page Research Training Program Plan (compiled as single unit)

These sections compose the Research Training Program Plan. Their combined length must not exceed 25 pages. The Background section opens with the program overview, goals, and objectives (serving the role that Specific Aims plays in R01s).

| File | Section |
|------|---------|
| `01_background.tex` | Background (program overview, goals/objectives, NIA alignment) |
| `02_program_admin.tex` | Program Administration |
| `03_program_faculty.tex` | Program Faculty |
| `04_proposed_training.tex` | Proposed Training |
| `05_program_evaluation.tex` | Program Evaluation |
| `06_trainee_candidates.tex` | Trainee Candidates and Retention |
| `07_institutional_environment.tex` | Institutional Environment and Commitment |
| `08_training_outcomes.tex` | Training Outcomes |

### Separate Attachments (each compiled independently for page-count checking)

| File | Section | Page Limit |
|------|---------|------------|
| `09_diversity_recruitment.tex` | Recruitment Plan to Enhance Diversity | 3 pages |
| `10_rcr_plan.tex` | Plan for Instruction in RCR | 3 pages |
| `12_reproducibility.tex` | Methods for Enhancing Reproducibility | 3 pages |
| `11_facilities_resources.tex` | Facilities & Other Resources | No limit |

### Supporting Files

| File | Purpose |
|------|---------|
| `references.bib` | Bibliography (shared across all sections) |
| `main.tex` | Master document for full compilation |

### Other Required Components (not LaTeX-managed)

These are submitted as separate forms/attachments but are not part of the LaTeX proposal:
- **Data Tables** (Tables 1-8) — trainee demographics, outcomes, faculty info
- **Faculty Biosketches** — expanded format addressing training/mentoring experience
- **Training Budget** — PHS 398 Training Budget form (stipends, not salaries; 8% IDC)
- **Letters of Support** — including institutional letter (max 10 pages from Provost/Dean)
- **Advisory Committee Plan** — recommended; filed as "Advisory_Committee.pdf"

## Required Content Elements (for Compliance Checking)

### RCR Plan Must Include
- Face-to-face instruction format (online-only is unacceptable)
- Minimum 8 contact hours
- Frequency: at least once per career stage, no less than every 4 years
- Subject matter coverage: conflict of interest, authorship, data management, human subjects, animal use, lab safety, research misconduct, ethics
- Named faculty participants (for renewals)

### Reproducibility Plan Must Include
- Training in scientific reasoning and rigorous research design
- Experimental methods and relevant biological variables
- Quantitative approaches and data analysis/interpretation
- Resource authentication (adapted to computational/data context)

### Program Faculty Must Address
- Mentor training plan: format, duration, frequency
- Topics: aligning expectations, effective communication, fostering independence, assessing understanding, professional development, articulating mentoring philosophy
- Mechanism for monitoring mentoring effectiveness
- Process for removing underperforming faculty

### Trainee Candidates Must Describe
- Multifactorial candidate review process
- Must go beyond GPA and standardized test scores
- Evidence-informed retention practices
- Tailored approaches recognizing trainee diversity

### Diversity Recruitment Must Include
- Specific strategies for identifying candidates from underrepresented groups
- Multifactorial recruitment approach
- Plans for retention and support

## Page Count Verification

Thresholds for warnings:
- Diversity Recruitment: warn if >3 pages
- RCR Plan: warn if >3 pages
- Reproducibility Plan: warn if >3 pages
- Program Plan (all 01-08 combined): warn if >25 pages
