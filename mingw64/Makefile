# This Makefile is vor the discount-VERSION subdirectory.

include mingw64-config-vars.inc

MKDLIB=libmarkdown
OBJS=mkdio.o markdown.o dumptree.o generate.o \
     resource.o docheader.o version.o toc.o css.o \
     xml.o Csio.o xmlpage.o basename.o emmatch.o \
     github_flavoured.o setup.o tags.o html5.o \
       flags.o
CSOURCES = $(OBJS:.o=.c)
default: all

all: $(MKDLIB)

.c.o:
	$(CC) $(CFLAGS) $(OPTIMIZE) -I. -o $@ -c $<

$(MKDLIB): $(OBJS)
	$(AR) crv $@.a $(OBJS) && \
	$(RANLIB) $@.a
