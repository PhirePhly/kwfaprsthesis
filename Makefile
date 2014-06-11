

default:
	mkdir -p out
	pdflatex -draftmode -output-directory out -jobname finnegan_thesis main.tex
	pdflatex -output-directory out -jobname finnegan_thesis main.tex

