---
paths:
  - "**/*.r"
  - "**/*.R"
  - "code/**"
---

# R Code Conventions

These standards apply to all R scripts in this repository.

---

## 1. Package Philosophy

Take a **minimalist but sensible** approach:

- **data.table** — Primary tool for data wrangling. Strongly preferred over tidyverse.
- **fixest** — Regression analysis (`feols`, etc.).
- **ggplot2** — Visualization.
- **here** — All file paths. Never `setwd()`, never absolute paths.
- **pacman** — Package management via `p_load()`.
- **collapse** — Fast grouped operations when needed.

Avoid elaborate tidyverse pipelines. data.table syntax is preferred for most data manipulation.

## 2. Script Structure

Every script should have a header and fit into a numbered pipeline:

```r
# ============================================================
# Project: [Project Name]
# Script: 01_clean_data.r - [description]
#
# Input: [files]
# Output: [files]
# ============================================================
```

Numbered scripts: `01_clean_source.r`, `02_make_panel.r`, `03_estimation.r`, etc.

Section separators: `# Section name -------`

A `main.r` orchestrator calls all scripts via `source(here("code", "01_...r"))`.

## 3. Path Management

- **Always use `here()`** to build file paths
- **Never use `setwd()`**
- **Never hardcode absolute paths**

```r
# Good
dt <- fread(here("raw_data", "source.csv"))
fwrite(results, here("temp_data", "processed.csv"))

# Bad
dt <- fread("/Users/cwing/projects/my_project/raw_data/source.csv")
setwd("~/projects/my_project")
```

## 4. Code Style: Explicitness vs Abstraction

- **Prefer explicitness** for core operations. It should be easy to see exactly where a regression gets run or a figure gets made.
- **Use functions and loops only when warranted** — when you'd otherwise write 20+ nearly-identical lines.
- **Avoid premature abstraction.** Three similar lines of code is often better than a function that obscures what's happening.

## 5. data.table Conventions

```r
# Column creation
dt[, new_col := old_col * 100]

# Aggregation
dt[, .(total = sum(value, na.rm = TRUE)), by = .(state, year)]

# Merging
panel <- merge(dt1, dt2, by = c("state", "year"))

# I/O
dt <- fread(here("raw_data", "file.csv"))
fwrite(dt, here("temp_data", "processed.csv"))
```

Do not mix tidyverse and data.table in the same pipeline.

## 6. Console Output Policy

- **Allowed:** `message()` for progress milestones only
- **Forbidden:** `cat()`, `print()`, ASCII banners, per-iteration output
- End each script with: `message("script_name.r complete: N rows written")`

## 7. ggplot2 Conventions

- **Separate plot creation from saving:**
  ```r
  p <- ggplot(data, aes(x, y)) + geom_point()
  ggsave(here("outputs", "figures", "plot.png"), p, width = 10, height = 8)
  ```
- **Titles on plots:** Include titles by default. When a plot is destined for a LaTeX figure, omit the title (let `\caption{}` handle it) — but keep the title in the R code as a comment so it's easy to toggle back.
- Explicit dimensions in `ggsave()`: `width`, `height` always specified
- Readable font sizes: `base_size >= 14`
- Direct text labels on lines instead of legends where feasible

## 8. Variable Naming

- **Snake_case** for everything
- Descriptive names: `tot_spend_per_100`, `adoption_year_quarter`, `n_rx_obesity`
- Consistent temporal variables: `year`, `quarter`, `year_quarter`

## 9. Reproducibility

- `set.seed()` called ONCE at top if randomness is used (YYYYMMDD format)
- All packages loaded at top via `pacman::p_load()` or `library()`
- All paths relative via `here()`
- `dir.create(..., recursive = TRUE, showWarnings = FALSE)` for output directories

## 10. Common Pitfalls

<!-- Add project-specific pitfalls here -->

| Pitfall | Impact | Prevention |
|---------|--------|------------|
| `setwd()` in scripts | Breaks on other machines | Use `here()` |
| `cat()` for status | Noisy stdout | Use `message()` sparingly |
| Tidyverse where data.table is clearer | Inconsistent style | Default to data.table |
| Nested `ggsave()` | Hard to debug | Separate creation from saving |
| Hardcoded absolute paths | Breaks on other machines | Use `here()` |
