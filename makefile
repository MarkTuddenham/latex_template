
# ~~~~~~ DIRS & FILES ~~~~~~
OUTPUT_FILE ?= main.pdf

TMP_DIR := tmp
CONTENT_DIR := content
INPUT_DIR := in
BIBS_DIR := bibs

ROOT_TEX_FILE_NAME := main
ROOT_TEX_FILE_PATH := map/$(ROOT_TEX_FILE_NAME).tex

WORD_COUNT := word_count.txt
WORD_COUNT_FILES := $(shell ls -A $(CONTENT_DIR)/ | grep -E "\.tex")
WORD_COUNT_PATHS := $(addprefix ./$(CONTENT_DIR)/, $(WORD_COUNT_FILES))
# ~~~~~~ COMMANDS ~~~~~~
RM_FORCE := rm -fv
LATEX_COMPILE := pdflatex
LATEX_COMPILE_OPTIONS := -halt-on-error -shell-escape -output-directory $(TMP_DIR)
BIB_COMPLIE := biber
GLOSSARIES_COMPLIE := makeglossaries

CLEAN_IGNORE_REGEX := "map|bibs|content|tmp|in|\.tex|\.pdf|makefile|.git|.gitignore|.vscode"


# ~~~~~~ PHONY ~~~~~~
.PHONY: clean open compile bib
.DEFAULT_GOAL: compile

# ~~~~~~ PHONY RULES ~~~~~~
compile: $(OUTPUT_FILE) bib

bib: $(TMP_DIR)/$(ROOT_TEX_FILE_NAME).bcf

clean:
	$(RM_FORCE) -r $(TMP_DIR)/*
	ls -A | grep -vE $(CLEAN_IGNORE_REGEX) | xargs -rt RM_FORCE

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
	@texcount -1 -sum $(WORD_COUNT_PATHS) > $(TMP_DIR)/$(WORD_COUNT)

$(TMP_DIR)/:
	@if [ ! -d $(TMP_DIR) ]; then mkdir $(TMP_DIR); fi
