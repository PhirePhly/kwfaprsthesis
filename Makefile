

default:
	mkdir -p out
	pdflatex -draftmode -output-directory out -jobname finnegan_thesis main.tex
	pdflatex -output-directory out -jobname finnegan_thesis main.tex

arrl:
	pdflatex -draftmode -output-directory out -jobname dcc_bell202 arrl_dcc_bell202.tex
	pdflatex -output-directory out -jobname dcc_bell202 arrl_dcc_bell202.tex

