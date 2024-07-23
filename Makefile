# Make CGEM poster template project
.PHONY: all pdf documentation

all: pdf documentation

documentation: Doc/example.png

pdf: poster-template.pdf

Doc/example.png: poster-template.pdf
	magick -density 300 $< -quality 90 $@

poster-template.pdf: poster-template.tex cgem-poster.cls bib.lua
	latexmk -pdflua $<
