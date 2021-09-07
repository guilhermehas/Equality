AGDA_EXEC ?= agda
FIX_WHITESPACE ?= fix-whitespace
RTS_OPTIONS = --latex --latex-dir .
AGDA = $(AGDA_EXEC) $(RTS_OPTIONS)
DOC = paper
PDF = ${DOC}.pdf
DOCTEX = ${DOC}.tex

LAGDA = ${DOC}.lagda.tex
SRC = ${DOC}.tex
LATEX ?= pdflatex

all: pdf

pdf: ${PDF}

${DOC}.pdf: ${LAGDA}
	${AGDA}   ${LAGDA}
	${LATEX}  ${DOCTEX}

install: pdf
	mkdir -p $(out)
	cp ${PDF} $(out)

clean:
	rm -rf latex

distclean: clean
	rm -f *.agdai
	rm -f _region_.tex
	rm -rf .auctex-auto
	rm -f *.log
	rm -f result
