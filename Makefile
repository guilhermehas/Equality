AGDA_EXEC ?= agda
FIX_WHITESPACE ?= fix-whitespace
RTS_OPTIONS = --latex --latex-dir .
AGDA = $(AGDA_EXEC) $(RTS_OPTIONS)
DOC = paper
SLIDES = slides
PDF = ${DOC}.pdf
SLIDESPDF = ${SLIDES}.pdf
DOCTEX = ${DOC}.tex
SLIDESTEX = ${SLIDES}.tex

LAGDA = ${DOC}.lagda.tex
SLIDESLAGDA = ${SLIDES}.lagda.tex
SRC = ${DOC}.tex
LATEX ?= pdflatex

all: pdf

pdf: ${PDF} ${SLIDESPDF}

${PDF}: ${LAGDA}
	${AGDA}   ${LAGDA}
	${LATEX}  ${DOCTEX}

${SLIDESPDF}: ${SLIDESLAGDA}
	${AGDA}   ${SLIDESLAGDA}
	${LATEX}  ${SLIDESTEX}

install: pdf
	mkdir -p $(out)
	cp *.pdf $(out)

clean:
	rm -rf latex

distclean: clean
	rm -f *.agdai
	rm -f _region_.tex
	rm -rf .auctex-auto
	rm -f *.log
	rm -f result
