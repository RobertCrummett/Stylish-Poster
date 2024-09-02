# Make CGEM poster template project
source = poster.tex
target = poster.pdf

pdf: $(target)

all: pdf doc

doc: $(target)
	magick -density 300 $< -quality 90 example.png

$(target): $(source) cgem-poster.cls bib.lua
	latexmk -pdflua $<

clean:
	latexmk -C -f $(target)

purge: clean
	rm -f Bib/
	rm -f Fig/
	rm -f README.markdown

.PHONY: all pdf doc clean purge
