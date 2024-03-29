# Copyright 2014 Jeffrey Kegler
# This file is part of Kollos.  Kollos is free software: you can
# redistribute it and/or modify it under the terms of the GNU Lesser
# General Public License as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any later version.
#
# Kollos is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser
# General Public License along with Kollos.  If not, see
# http://www.gnu.org/licenses/.

# Code for the "Scanless interface" or SLIF, an upper
# layer for libmarpa.

CWEAVE = cweave -p
CTANGLE = ctangle -p

.PHONY: all

.SUFFIXES: .dvi .tex .w .pdf

.w.tex:
	$(CWEAVE) $*

.tex.dvi:	
	tex $<

.w.dvi:
	make $*.tex
	make $*.dvi

.w.c:
	$(CTANGLE) $*

.w.o:
	make $*.c
	make $*.o

.w.pdf:
	make $*.tex
	pdftex -interaction=batchmode -halt-on-error $* || cat $*.log

all: marpa_slif.pdf sources

sources: marpa_slif.c marpa_slif.h.p50 marpa_slif.h.p80 marpa_slif.h-ops marpa_slif.c-ops

C_LANGUAGE_PREAMBLE = ../shared/license.c ../shared/do_not_edit.c
MARPA_SLIF_H_PIECES =  $(C_LANGUAGE_PREAMBLE) marpa_slif.h.p50 marpa_slif.h.p80
MARPA_SLIF_C_PIECES = $(C_LANGUAGE_PREAMBLE) marpa_slif.c.p10 marpa_slif.c-ops \
  marpa_slif.c.p40 marpa_slif.c.p50

marpa_slif.h.p50 marpa_slif.c.p10 marpa_slif.c.p50: ../shared/copyright_page_license.w marpa_slif.w
	$(CTANGLE) marpa_slif.w

cwebmac.tex: ../shared/cwebmac.tex
	cp $? $@

marpa_slif.tex: cwebmac.tex ../shared/copyright_page_license.w

marpa_slif.pdf: marpa_slif.tex

marpa_slif.c: $(MARPA_SLIF_C_PIECES)
	cat $(MARPA_SLIF_C_PIECES) > $@

CPPWRAP = perl ../bin/cppwrap.pl

marpa_slif.c.p40: marpa_slif.w
	perl w2private_h.pl < $? | $(CPPWRAP) $@ > $@

marpa_slif.h.p80: api.texi internal.texi
	cat api.texi internal.texi | \
	  perl ../bin/texi2proto.pl /dev/null > marpa_slif.h.p80

marpa_slif.h-ops marpa_slif.c-ops: create_ops.pl
	perl create_ops.pl marpa_slif.h-ops | $(CPPWRAP) marpa_slif.c-ops > marpa_slif.c-ops

update_texi:
	emacs -batch internal.texi \
	    -f texinfo-every-node-update \
	    -f texinfo-all-menus-update \
	    -f save-buffer -kill

CLEAN_FILES = marpa_slif.c marpa_slif.c.p10 marpa_slif.c.p40 marpa_slif.c.p50 \
  marpa_slif.h.p50 marpa_slif.h.p80 \
  marpa_slif.idx marpa_slif.log marpa_slif.pdf marpa_slif.scn marpa_slif.tex marpa_slif.toc \
  cwebmac.tex

clean:
	rm -f $(CLEAN_FILES)
