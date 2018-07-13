
clean_ignore = "map|bibs|content|tmp|in|\.tex|\.pdf|makefile|.git|.gitignore|.vscode"
temp_dir = tmp

ifndef $(output)
output = main.pdf
endif

word_count_files = $(shell ls -A content/ | grep -E "\.tex")
word_count_paths = $(addprefix ./content/, $(word_count_files))
compile_cmd = pdflatex -halt-on-error -shell-escape -output-directory tmp map/main.tex


.PHONY: clean open compile bib
.DEFAULT_GOAL: compile

compile: $(temp_dir)/main.pdf

bib: $(temp_dir)/main.blg

clean:
	ls -A $(temp_dir)/ | grep -vE ".gitignore" | sed -e 's|^|$(temp_dir)/|' | xargs -rt rm
	ls -A | grep -vE $(clean_ignore) | xargs -rt rm

open: main.pdf
	xdg-open main.pdf &

$(temp_dir)/main.pdf: $(temp_dir)/word_count.txt content/*.tex in/ $(temp_dir)/main.blg
	$(compile_cmd)
	mv $(temp_dir)/main.pdf $(output)

$(temp_dir)/main.blg: bibs/* $(temp_dir)/
	$(compile_cmd)
	biber $(temp_dir)/main
	$(compile_cmd)

$(temp_dir)/word_count.txt: $(word_count_paths) $(temp_dir)/
	texcount -1 -sum $(word_count_paths) > $(temp_dir)/word_count.txt

$(temp_dir)/:
	if [ ! -d $(temp_dir) ]; then mkdir $(temp_dir); fi
