# Make CGEM poster template project
source = poster.tex
target = poster.pdf

pdf: $(target)

all: pdf doc

doc: $(target)
	magick -density 300 $< -quality 90 example.png

$(target): $(source) cgem-poster.cls bib.lua
	latexmk -pdflua $<

.PHONY: all pdf doc
