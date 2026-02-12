# Figure Style Guide

All ggplot2 figures in this project follow these conventions.

## Colour Palette

```r
pal <- c(
  navy   = "#000080",
  pink   = "#FF1493",
  teal   = "#2A9D8F",
  orange = "#D4780A",
  purple = "#6A3D9A",
  slate  = "#708090"
)
```

- **Primary pair:** navy + pink (use for two-series plots)
- **Extended:** teal, orange, purple, slate (add as needed for 3+ series)
- **Bar charts:** navy fill; use navy gradient for ordered categories
- **Regression lines / fit lines:** pink

## Theme

```r
theme_clean <- theme_bw() +
  theme(
    panel.background = element_rect(fill = "white", colour = NA),
    plot.background  = element_rect(fill = "white", colour = NA),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line        = element_line(colour = "black", linewidth = 0.4),
    panel.border     = element_blank(),
    text = element_text(size = 12)
  )
```

Key principles:
- **Show axes.** Always have visible x and y axis lines.
- **No grid.** Remove both major and minor grid lines unless there is a specific reason to keep them.
- **White background.** No grey panel fill.

## Labels Over Legends

- **Prefer direct text labels** on or near lines/points rather than a separate legend.
- Use `annotate("text", ...)` or `geom_text()` to label series at endpoints or peaks.
- Use `coord_cartesian(clip = "off")` with extra `plot.margin` when labels extend beyond the plot area.
- Set `legend.position = "none"` when direct labels are used.
- Use colour-matched labels (same colour as the line/point they identify).

## Line Plots

- **All lines solid by default.** Do not use dashed lines to distinguish series — colour and labels handle that.
- Use `linewidth = 1` for primary series, `linewidth = 0.8` for secondary.

## Titles

- Include titles on working plots.
- When a plot is destined for a LaTeX figure, omit the title (let `\caption{}` handle it) but keep the title in the R code as a comment for easy toggling.
