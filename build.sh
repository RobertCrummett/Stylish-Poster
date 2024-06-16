latexmk -pdflatex=lualatex -pdf -f poster-template.tex
latexmk -c
rm -rf *.bbl *.nav *.xml *.snm
