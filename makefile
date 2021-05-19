
# ~~~~~~ DIRS & FILES ~~~~~~
OUTPUT_FILE ?= main.pdf

TMP_DIR := tmp
CONTENT_DIR := content
INPUT_DIR := in
BIBS_DIR := bibs

ROOT_TEX_FILE_NAME := main
ROOT_TEX_FILE_PATH := map/$(ROOT_TEX_FILE_NAME).tex

WORD_COUNT := word_count.txt

# ~~~~~~ COMMANDS ~~~~~~
RM_FORCE := rm -fv
LATEX_COMPILE := pdflatex
LATEX_COMPILE_OPTIONS := -halt-on-error -shell-escape -output-directory $(TMP_DIR)
BIB_COMPLIE := biber
GLOSSARIES_COMPLIE := makeglossaries


# ~~~~~~ PHONY ~~~~~~
.PHONY: clean open compile bib
.DEFAULT_GOAL: compile

# ~~~~~~ PHONY RULES ~~~~~~
compile: $(OUTPUT_FILE) bib

bib: $(TMP_DIR)/$(ROOT_TEX_FILE_NAME).bcf

clean:
	@$(RM_FORCE) -r $(TMP_DIR)/*

open: $(OUTPUT_FILE)
	xdg-open $(OUTPUT_FILE) &

# ~~~~~~ FILE RULES ~~~~~~
$(OUTPUT_FILE): $(TMP_DIR)/$(ROOT_TEX_FILE_NAME).pdf
	@mv $(TMP_DIR)/$(ROOT_TEX_FILE_NAME).pdf $(OUTPUT_FILE)

$(TMP_DIR)/$(ROOT_TEX_FILE_NAME).pdf: $(TMP_DIR)/$(WORD_COUNT) $(CONTENT_DIR)/*.tex $(INPUT_DIR)/ $(TMP_DIR)/$(ROOT_TEX_FILE_NAME).bcf
	@$(LATEX_COMPILE) $(LATEX_COMPILE_OPTIONS) $(ROOT_TEX_FILE_PATH)
	@$(GLOSSARIES_COMPLIE) -d $(TMP_DIR) $(ROOT_TEX_FILE_NAME)
	@$(LATEX_COMPILE) $(LATEX_COMPILE_OPTIONS) $(ROOT_TEX_FILE_PATH)

$(TMP_DIR)/$(ROOT_TEX_FILE_NAME).bcf: $(BIBS_DIR)/*.bib
	@$(LATEX_COMPILE) $(LATEX_COMPILE_OPTIONS) $(ROOT_TEX_FILE_PATH)
	@$(BIB_COMPLIE) $(TMP_DIR)/$(ROOT_TEX_FILE_NAME)

$(TMP_DIR)/$(WORD_COUNT): $(WORD_COUNT_PATHS) $(TMP_DIR)/
	@texcount -1 -sum -merge -dir=$(CONTENT_DIR) $(ROOT_TEX_FILE) > $(TMP_DIR)/$(WORD_COUNT)

$(TMP_DIR)/:
	@if [ ! -d $(TMP_DIR) ]; then mkdir $(TMP_DIR); fi
