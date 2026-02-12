# Makefile for T32 Grant Proposal — PDF and Word builds
#
# Usage (from project root):
#   make -C proposal/pandoc pdf          Build submission-ready PDF
#   make -C proposal/pandoc word         Build Word doc for collaborators
#   make -C proposal/pandoc word-section SEC=01_background   Single section to Word
#   make -C proposal/pandoc pages        Compile and report page count per section
#   make -C proposal/pandoc clean        Remove build artifacts
#
# Prerequisites: latexmk, xelatex, pandoc, pdfinfo (from poppler)

# Paths (relative to this Makefile's location in proposal/pandoc/)
PROPOSAL_DIR := ..
PROJECT_ROOT := ../..
BUILD_DIR    := $(PROJECT_ROOT)/build
REFERENCE    := reference.docx
BIB          := $(PROPOSAL_DIR)/references.bib

# Source files
MAIN_TEX     := $(PROPOSAL_DIR)/main.tex
SECTIONS     := $(wildcard $(PROPOSAL_DIR)/[0-9]*.tex)

# Output files
PDF_OUT      := $(BUILD_DIR)/T32_proposal.pdf
WORD_OUT     := $(BUILD_DIR)/T32_proposal.docx

# Tools
LATEXMK      := latexmk -pdfxe -cd -outdir=$(abspath $(BUILD_DIR))
PANDOC       := pandoc

# ---------------------------------------------------------------
# Targets
# ---------------------------------------------------------------

.PHONY: pdf word word-section pages clean all

all: pdf word

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# --- PDF build (submission-ready) ---
pdf: | $(BUILD_DIR)
	$(LATEXMK) $(abspath $(MAIN_TEX))
	@echo "PDF built: $(BUILD_DIR)/main.pdf"
	@if command -v pdfinfo >/dev/null 2>&1; then \
		echo "Total pages:"; \
		pdfinfo $(BUILD_DIR)/main.pdf | grep Pages; \
	fi

# --- Word build (for collaborators) ---
# Concatenates all .tex section files, strips LaTeX commands pandoc can't handle,
# then converts via pandoc with the reference.docx for styling.
word: | $(BUILD_DIR)
	@echo "Building Word document..."
	$(PANDOC) \
		--from=latex \
		--to=docx \
		--reference-doc=$(REFERENCE) \
		--bibliography=$(BIB) \
		--citeproc \
		--output=$(WORD_OUT) \
		$(sort $(SECTIONS))
	@echo "Word doc built: $(WORD_OUT)"

# --- Single section to Word ---
# Usage: make -C proposal/pandoc word-section SEC=01_background
word-section: | $(BUILD_DIR)
ifndef SEC
	$(error SEC is not set. Usage: make word-section SEC=01_background)
endif
	@echo "Building Word document for section: $(SEC)..."
	$(PANDOC) \
		--from=latex \
		--to=docx \
		--reference-doc=$(REFERENCE) \
		--bibliography=$(BIB) \
		--citeproc \
		--output=$(BUILD_DIR)/$(SEC).docx \
		$(PROPOSAL_DIR)/$(SEC).tex
	@echo "Word doc built: $(BUILD_DIR)/$(SEC).docx"

# --- Page count per section ---
pages: pdf
	@echo ""
	@echo "=== Page Count Report ==="
	@echo "Total document:"
	@if command -v pdfinfo >/dev/null 2>&1; then \
		pdfinfo $(BUILD_DIR)/main.pdf | grep Pages; \
	else \
		echo "  pdfinfo not found — install poppler to get page counts"; \
	fi
	@echo ""
	@echo "Note: For per-section page counts, compile individual sections"
	@echo "using the toggle flags in main.tex."

# --- Clean build artifacts ---
clean:
	rm -rf $(BUILD_DIR)
	@echo "Build directory cleaned."
