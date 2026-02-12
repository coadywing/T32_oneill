# ============================================================
# Project: [PROJECT NAME]
# Script: main.r - Master pipeline
#
# Purpose:
#   Run this script to reproduce all results from scratch.
#   Each sourced script handles a discrete piece of work.
#
# Usage:
#   Open the .Rproj file in RStudio, then:
#   source("code/main.r")
# ============================================================

library(here)

# -- Data cleaning ----------------------------------------------------------
# source(here("code", "01_clean_source1.r"))
# source(here("code", "02_clean_source2.r"))

# -- Panel construction -----------------------------------------------------
# source(here("code", "03_make_panel.r"))

# -- Estimation --------------------------------------------------------------
# source(here("code", "04_estimation.r"))

# -- Figures -----------------------------------------------------------------
# source(here("code", "05_figures.r"))

# -- Export results to LaTeX -------------------------------------------------
# source(here("code", "06_export_results_tex.r"))

message("main.r complete")
