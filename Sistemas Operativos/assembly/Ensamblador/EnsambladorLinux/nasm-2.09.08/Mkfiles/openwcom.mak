# -*- makefile -*-
#
# Makefile for building NASM using OpenWatcom
# cross-compile on a DOS/Win32/OS2/Linux platform host
#

top_srcdir  = .
srcdir      = .
VPATH       = .;$(srcdir)/output;$(srcdir)/lib
prefix      = C:\Program Files\NASM
exec_prefix = $(prefix)
bindir      = $(prefix)\bin
mandir      = $(prefix)\man

CC      = *wcl386
DEBUG       =
CFLAGS      = -zq -6 -ox -wx -ze -fpi $(DEBUG)
BUILD_CFLAGS    = $(CFLAGS) $(%TARGET_CFLAGS)
INTERNAL_CFLAGS = -I$(srcdir) -I. -DHAVE_CONFIG_H
ALL_CFLAGS  = $(BUILD_CFLAGS) $(INTERNAL_CFLAGS)
LD      = *wlink
LDEBUG      =
LDFLAGS     = op quiet $(%TARGET_LFLAGS) $(LDEBUG)
LIBS        =
PERL        = perl -I$(srcdir)/perllib

STRIP       = wstrip

# Binary suffixes
O               = obj
X               = .exe

# WMAKE errors out if a suffix is declared more than once, including
# its own built-in declarations.  Thus, we need to explicitly clear the list
# first.  Also, WMAKE only allows implicit rules that point "to the left"
# in this list!
.SUFFIXES:
.SUFFIXES: .man .1 .$(O) .i .c

# Needed to find C files anywhere but in the current directory
.c : $(VPATH)

.c.$(O):
    @set INCLUDE=
    $(CC) -c $(ALL_CFLAGS) -fo=$^@ $[@

#-- Begin File Lists --#
# Edit in Makefile.in, not here!
NASM =	nasm.$(O) nasmlib.$(O) ver.$(O) &
	raa.$(O) saa.$(O) rbtree.$(O) &
	float.$(O) insnsa.$(O) insnsb.$(O) &
	directiv.$(O) &
	assemble.$(O) labels.$(O) hashtbl.$(O) crc64.$(O) parser.$(O) &
	output/outform.$(O) output/outlib.$(O) output/nulldbg.$(O) &
	output/nullout.$(O) &
	output/outbin.$(O) output/outaout.$(O) output/outcoff.$(O) &
	output/outelf.$(O) output/outelf32.$(O) output/outelf64.$(O) &
	output/outobj.$(O) output/outas86.$(O) output/outrdf2.$(O) &
	output/outdbg.$(O) output/outieee.$(O) output/outmac32.$(O) &
	output/outmac64.$(O) preproc.$(O) quote.$(O) pptok.$(O) &
	macros.$(O) listing.$(O) eval.$(O) exprlib.$(O) stdscan.$(O) &
	strfunc.$(O) tokhash.$(O) regvals.$(O) regflags.$(O) &
	ilog2.$(O) &
	lib/strlcpy.$(O)

NDISASM = ndisasm.$(O) disasm.$(O) sync.$(O) nasmlib.$(O) ver.$(O) &
	insnsd.$(O) insnsb.$(O) insnsn.$(O) regs.$(O) regdis.$(O)
#-- End File Lists --#

what:   .SYMBOLIC
    @echo Please build "dos", "win32", "os2" or "linux386"

dos:    .SYMBOLIC
    @set TARGET_CFLAGS=-bt=DOS -I"$(%WATCOM)/h"
    @set TARGET_LFLAGS=sys causeway
    @%make all

win32:  .SYMBOLIC
    @set TARGET_CFLAGS=-bt=NT -I"$(%WATCOM)/h" -I"$(%WATCOM)/h/nt"
    @set TARGET_LFLAGS=sys nt
    @%make all

os2:    .SYMBOLIC
    @set TARGET_CFLAGS=-bt=NT -I"$(%WATCOM)/h" -I"$(%WATCOM)/h/os2"
    @set TARGET_LFLAGS=sys os2v2
    @%make all

linux386:   .SYMBOLIC
    @set TARGET_CFLAGS=-bt=LINUX -I"$(%WATCOM)/lh"
    @set TARGET_LFLAGS=sys linux
    @%make all

all: config.h perlreq nasm$(X) ndisasm$(X) .SYMBOLIC
#   cd rdoff && $(MAKE) all

nasm$(X): $(NASM)
    $(LD) $(LDFLAGS) name nasm$(X) file {$(NASM)} $(LIBS)

ndisasm$(X): $(NDISASM)
    $(LD) $(LDFLAGS) name ndisasm$(X) file {$(NDISASM)} $(LIBS)

# These source files are automagically generated from a single
# instruction-table file by a Perl script. They're distributed,
# though, so it isn't necessary to have Perl just to recompile NASM
# from the distribution.

insnsb.c: insns.dat insns.pl
    $(PERL) $(srcdir)/insns.pl -b $(srcdir)/insns.dat
insnsa.c: insns.dat insns.pl
    $(PERL) $(srcdir)/insns.pl -a $(srcdir)/insns.dat
insnsd.c: insns.dat insns.pl
    $(PERL) $(srcdir)/insns.pl -d $(srcdir)/insns.dat
insnsi.h: insns.dat insns.pl
    $(PERL) $(srcdir)/insns.pl -i $(srcdir)/insns.dat
insnsn.c: insns.dat insns.pl
    $(PERL) $(srcdir)/insns.pl -n $(srcdir)/insns.dat

# These files contains all the standard macros that are derived from
# the version number.
version.h: version version.pl
    $(PERL) $(srcdir)/version.pl h < $(srcdir)/version > version.h

version.mac: version version.pl
    $(PERL) $(srcdir)/version.pl mac < $(srcdir)/version > version.mac

# This source file is generated from the standard macros file
# `standard.mac' by another Perl script. Again, it's part of the
# standard distribution.

macros.c: macros.pl standard.mac version.mac macros/*.mac output/*.mac
    $(PERL) $<

# These source files are generated from regs.dat by yet another
# perl script.
regs.c: regs.dat regs.pl
    $(PERL) $(srcdir)/regs.pl c $(srcdir)/regs.dat > regs.c
regflags.c: regs.dat regs.pl
    $(PERL) $(srcdir)/regs.pl fc $(srcdir)/regs.dat > regflags.c
regdis.c: regs.dat regs.pl
    $(PERL) $(srcdir)/regs.pl dc $(srcdir)/regs.dat > regdis.c
regdis.h: regs.dat regs.pl
    $(PERL) $(srcdir)/regs.pl dh $(srcdir)/regs.dat > regdis.h
regvals.c: regs.dat regs.pl
    $(PERL) $(srcdir)/regs.pl vc $(srcdir)/regs.dat > regvals.c
regs.h: regs.dat regs.pl
    $(PERL) $(srcdir)/regs.pl h $(srcdir)/regs.dat > regs.h

# Assembler token hash
tokhash.c: insns.dat regs.dat tokens.dat tokhash.pl perllib/phash.ph
    $(PERL) $(srcdir)/tokhash.pl c $(srcdir)/insns.dat $(srcdir)/regs.dat &
        $(srcdir)/tokens.dat > tokhash.c

# Assembler token metadata
tokens.h: insns.dat regs.dat tokens.dat tokhash.pl perllib/phash.ph
    $(PERL) $(srcdir)/tokhash.pl h $(srcdir)/insns.dat $(srcdir)/regs.dat &
        $(srcdir)/tokens.dat > tokens.h

# Preprocessor token hash
pptok.h: pptok.dat pptok.pl perllib/phash.ph
    $(PERL) $(srcdir)/pptok.pl h $(srcdir)/pptok.dat pptok.h
pptok.c: pptok.dat pptok.pl perllib/phash.ph
    $(PERL) $(srcdir)/pptok.pl c $(srcdir)/pptok.dat pptok.c
pptok.ph: pptok.dat pptok.pl perllib/phash.ph
    $(PERL) $(srcdir)/pptok.pl ph $(srcdir)/pptok.dat pptok.ph

# Directives hash
directiv.h: directiv.dat directiv.pl perllib/phash.ph
    $(PERL) $(srcdir)/directiv.pl h $(srcdir)/directiv.dat directiv.h
directiv.c: directiv.dat directiv.pl perllib/phash.ph
    $(PERL) $(srcdir)/directiv.pl c $(srcdir)/directiv.dat directiv.c

# This target generates all files that require perl.
# This allows easier generation of distribution (see dist target).
PERLREQ = pptok.ph macros.c insnsb.c insnsa.c insnsd.c insnsi.h insnsn.c &
      regs.c regs.h regflags.c regdis.c regdis.h regvals.c &
      tokhash.c tokens.h pptok.h pptok.c &
      directiv.c directiv.h &
      version.h version.mac
perlreq: $(PERLREQ) .SYMBOLIC

clean: .SYMBOLIC
    rm -f *.$(O) *.s *.i
    rm -f lib/*.$(O) lib/*.s lib/*.i
    rm -f output/*.$(O) output/*.s output/*.i
    rm -f config.h config.log config.status
    rm -f nasm$(X) ndisasm$(X)
#   cd rdoff && $(MAKE) clean

distclean: clean .SYMBOLIC
    rm -f config.h config.log config.status
    rm -f Makefile *~ *.bak *.lst *.bin
    rm -f output/*~ output/*.bak
    rm -f test/*.lst test/*.bin test/*.$(O) test/*.bin
#   -del /s autom4te*.cache
#   cd rdoff && $(MAKE) distclean

cleaner: clean .SYMBOLIC
    rm -f $(PERLREQ)
    rm -f *.man
    rm -f nasm.spec
#   cd doc && $(MAKE) clean

spotless: distclean cleaner .SYMBOLIC
    rm -f doc/Makefile doc/*~ doc/*.bak

strip: .SYMBOLIC
    $(STRIP) *.exe

rdf:
#   cd rdoff && $(MAKE)

doc:
#   cd doc && $(MAKE) all

everything: all doc rdf

config.h: Mkfiles/openwcom.mak
    @echo Creating $@
    @%create $@
    @%append $@ $#define HAVE_DECL_STRCASECMP 1
    @%append $@ $#define HAVE_DECL_STRICMP 1
    @%append $@ $#define HAVE_DECL_STRLCPY 1
    @%append $@ $#define HAVE_DECL_STRNCASECMP 1
    @%append $@ $#define HAVE_DECL_STRNICMP 1
    @%append $@ $#define HAVE_INTTYPES_H 1
    @%append $@ $#define HAVE_LIMITS_H 1
    @%append $@ $#define HAVE_MEMORY_H 1
    @%append $@ $#define HAVE_SNPRINTF 1
    @%append $@ $#define HAVE_STDBOOL_H 1
    @%append $@ $#define HAVE_STDINT_H 1
    @%append $@ $#define HAVE_STDLIB_H 1
    @%append $@ $#define HAVE_STRCASECMP 1
    @%append $@ $#define HAVE_STRCSPN 1
    @%append $@ $#define HAVE_STRICMP 1
    @%append $@ $#define HAVE_STRINGS_H 1
    @%append $@ $#define HAVE_STRING_H 1
    @%append $@ $#define HAVE_STRLCPY 1
    @%append $@ $#define HAVE_STRNCASECMP 1
    @%append $@ $#define HAVE_STRNICMP 1
    @%append $@ $#define HAVE_STRSPN 1
    @%append $@ $#define HAVE_SYS_STAT_H 1
    @%append $@ $#define HAVE_SYS_TYPES_H 1
    @%append $@ $#define HAVE_UNISTD_H 1
    @%append $@ $#define HAVE_VSNPRINTF 1
    @%append $@ $#define STDC_HEADERS 1

#
# This build dependencies in *ALL* makefiles.  Partially for that reason,
# it's expected to be invoked manually.
#
alldeps: perlreq .SYMBOLIC
    $(PERL) syncfiles.pl Makefile.in Mkfiles/openwcom.mak
    $(PERL) mkdep.pl -M Makefile.in Mkfiles/openwcom.mak -- . output lib

#-- Magic hints to mkdep.pl --#
# @object-ending: ".$(O)"
# @path-separator: "/"
# @exclude: ""
# @continuation: "&"
#-- Everything below is generated by mkdep.pl - do not edit --#
assemble.$(O): assemble.c assemble.h compiler.h config.h directiv.h insns.h &
 insnsi.h nasm.h nasmlib.h opflags.h pptok.h preproc.h regs.h tables.h &
 tokens.h
crc64.$(O): crc64.c compiler.h config.h nasmlib.h
directiv.$(O): directiv.c compiler.h config.h directiv.h hashtbl.h insnsi.h &
 nasm.h nasmlib.h opflags.h pptok.h preproc.h regs.h
disasm.$(O): disasm.c compiler.h config.h directiv.h disasm.h insns.h &
 insnsi.h nasm.h nasmlib.h opflags.h pptok.h preproc.h regdis.h regs.h &
 sync.h tables.h tokens.h
eval.$(O): eval.c compiler.h config.h directiv.h eval.h float.h insnsi.h &
 labels.h nasm.h nasmlib.h opflags.h pptok.h preproc.h regs.h
exprlib.$(O): exprlib.c compiler.h config.h directiv.h insnsi.h nasm.h &
 nasmlib.h opflags.h pptok.h preproc.h regs.h
float.$(O): float.c compiler.h config.h directiv.h float.h insnsi.h nasm.h &
 nasmlib.h opflags.h pptok.h preproc.h regs.h
hashtbl.$(O): hashtbl.c compiler.h config.h directiv.h hashtbl.h insnsi.h &
 nasm.h nasmlib.h opflags.h pptok.h preproc.h regs.h
ilog2.$(O): ilog2.c compiler.h config.h nasmlib.h
insnsa.$(O): insnsa.c compiler.h config.h directiv.h insns.h insnsi.h nasm.h &
 nasmlib.h opflags.h pptok.h preproc.h regs.h tokens.h
insnsb.$(O): insnsb.c compiler.h config.h directiv.h insns.h insnsi.h nasm.h &
 nasmlib.h opflags.h pptok.h preproc.h regs.h tokens.h
insnsd.$(O): insnsd.c compiler.h config.h directiv.h insns.h insnsi.h nasm.h &
 nasmlib.h opflags.h pptok.h preproc.h regs.h tokens.h
insnsn.$(O): insnsn.c compiler.h config.h insnsi.h opflags.h tables.h
labels.$(O): labels.c compiler.h config.h directiv.h hashtbl.h insnsi.h &
 nasm.h nasmlib.h opflags.h pptok.h preproc.h regs.h
lib/snprintf.$(O): lib/snprintf.c compiler.h config.h nasmlib.h
lib/strlcpy.$(O): lib/strlcpy.c compiler.h config.h
lib/vsnprintf.$(O): lib/vsnprintf.c compiler.h config.h nasmlib.h
listing.$(O): listing.c compiler.h config.h directiv.h insnsi.h listing.h &
 nasm.h nasmlib.h opflags.h pptok.h preproc.h regs.h
macros.$(O): macros.c compiler.h config.h directiv.h hashtbl.h insnsi.h &
 nasm.h nasmlib.h opflags.h output/outform.h pptok.h preproc.h regs.h &
 tables.h
nasm.$(O): nasm.c assemble.h compiler.h config.h directiv.h eval.h float.h &
 insns.h insnsi.h labels.h listing.h nasm.h nasmlib.h opflags.h &
 output/outform.h parser.h pptok.h preproc.h raa.h regs.h saa.h stdscan.h &
 tokens.h
nasmlib.$(O): nasmlib.c compiler.h config.h directiv.h insns.h insnsi.h &
 nasm.h nasmlib.h opflags.h pptok.h preproc.h regs.h tokens.h
ndisasm.$(O): ndisasm.c compiler.h config.h directiv.h disasm.h insns.h &
 insnsi.h nasm.h nasmlib.h opflags.h pptok.h preproc.h regs.h sync.h &
 tokens.h
output/nulldbg.$(O): output/nulldbg.c compiler.h config.h directiv.h &
 insnsi.h nasm.h nasmlib.h opflags.h pptok.h preproc.h regs.h
output/nullout.$(O): output/nullout.c compiler.h config.h directiv.h &
 insnsi.h nasm.h nasmlib.h opflags.h output/outlib.h pptok.h preproc.h &
 regs.h
output/outaout.$(O): output/outaout.c compiler.h config.h directiv.h eval.h &
 insnsi.h nasm.h nasmlib.h opflags.h output/outform.h output/outlib.h &
 pptok.h preproc.h raa.h regs.h saa.h stdscan.h
output/outas86.$(O): output/outas86.c compiler.h config.h directiv.h &
 insnsi.h nasm.h nasmlib.h opflags.h output/outform.h output/outlib.h &
 pptok.h preproc.h raa.h regs.h saa.h
output/outbin.$(O): output/outbin.c compiler.h config.h directiv.h eval.h &
 insnsi.h labels.h nasm.h nasmlib.h opflags.h output/outform.h &
 output/outlib.h pptok.h preproc.h regs.h saa.h stdscan.h
output/outcoff.$(O): output/outcoff.c compiler.h config.h directiv.h eval.h &
 insnsi.h nasm.h nasmlib.h opflags.h output/outform.h output/outlib.h &
 output/pecoff.h pptok.h preproc.h raa.h regs.h saa.h
output/outdbg.$(O): output/outdbg.c compiler.h config.h directiv.h insnsi.h &
 nasm.h nasmlib.h opflags.h output/outform.h pptok.h preproc.h regs.h
output/outelf.$(O): output/outelf.c compiler.h config.h directiv.h insnsi.h &
 nasm.h nasmlib.h opflags.h output/dwarf.h output/elf.h output/outelf.h &
 output/outform.h pptok.h preproc.h regs.h
output/outelf32.$(O): output/outelf32.c compiler.h config.h directiv.h &
 eval.h insnsi.h nasm.h nasmlib.h opflags.h output/dwarf.h output/elf.h &
 output/outelf.h output/outform.h output/outlib.h output/stabs.h pptok.h &
 preproc.h raa.h rbtree.h regs.h saa.h stdscan.h
output/outelf64.$(O): output/outelf64.c compiler.h config.h directiv.h &
 eval.h insnsi.h nasm.h nasmlib.h opflags.h output/dwarf.h output/elf.h &
 output/outelf.h output/outform.h output/outlib.h output/stabs.h pptok.h &
 preproc.h raa.h rbtree.h regs.h saa.h stdscan.h
output/outform.$(O): output/outform.c compiler.h config.h directiv.h &
 insnsi.h nasm.h nasmlib.h opflags.h output/outform.h pptok.h preproc.h &
 regs.h
output/outieee.$(O): output/outieee.c compiler.h config.h directiv.h &
 insnsi.h nasm.h nasmlib.h opflags.h output/outform.h output/outlib.h &
 pptok.h preproc.h regs.h
output/outlib.$(O): output/outlib.c compiler.h config.h directiv.h insnsi.h &
 nasm.h nasmlib.h opflags.h output/outlib.h pptok.h preproc.h regs.h
output/outmac32.$(O): output/outmac32.c compiler.h config.h directiv.h &
 eval.h insnsi.h nasm.h nasmlib.h opflags.h output/outform.h output/outlib.h &
 pptok.h preproc.h raa.h regs.h saa.h
output/outmac64.$(O): output/outmac64.c compiler.h config.h directiv.h &
 insnsi.h nasm.h nasmlib.h opflags.h output/outform.h output/outlib.h &
 pptok.h preproc.h raa.h regs.h saa.h
output/outobj.$(O): output/outobj.c compiler.h config.h directiv.h eval.h &
 insnsi.h nasm.h nasmlib.h opflags.h output/outform.h output/outlib.h &
 pptok.h preproc.h regs.h stdscan.h
output/outrdf2.$(O): output/outrdf2.c compiler.h config.h directiv.h &
 insnsi.h nasm.h nasmlib.h opflags.h output/outform.h output/outlib.h &
 pptok.h preproc.h rdoff/rdoff.h regs.h saa.h
parser.$(O): parser.c compiler.h config.h directiv.h eval.h float.h insns.h &
 insnsi.h nasm.h nasmlib.h opflags.h parser.h pptok.h preproc.h regs.h &
 stdscan.h tables.h tokens.h
pptok.$(O): pptok.c compiler.h config.h hashtbl.h nasmlib.h pptok.h &
 preproc.h
preproc.$(O): preproc.c compiler.h config.h directiv.h eval.h hashtbl.h &
 insnsi.h nasm.h nasmlib.h opflags.h pptok.h preproc.h quote.h regs.h &
 stdscan.h tables.h tokens.h
quote.$(O): quote.c compiler.h config.h nasmlib.h quote.h
raa.$(O): raa.c compiler.h config.h nasmlib.h raa.h
rbtree.$(O): rbtree.c compiler.h config.h rbtree.h
regdis.$(O): regdis.c regdis.h regs.h
regflags.$(O): regflags.c compiler.h config.h directiv.h insnsi.h nasm.h &
 nasmlib.h opflags.h pptok.h preproc.h regs.h tables.h
regs.$(O): regs.c compiler.h config.h insnsi.h opflags.h tables.h
regvals.$(O): regvals.c compiler.h config.h insnsi.h opflags.h tables.h
saa.$(O): saa.c compiler.h config.h nasmlib.h saa.h
stdscan.$(O): stdscan.c compiler.h config.h directiv.h insns.h insnsi.h &
 nasm.h nasmlib.h opflags.h pptok.h preproc.h quote.h regs.h stdscan.h &
 tokens.h
strfunc.$(O): strfunc.c compiler.h config.h directiv.h insnsi.h nasm.h &
 nasmlib.h opflags.h pptok.h preproc.h regs.h
sync.$(O): sync.c compiler.h config.h nasmlib.h sync.h
tokhash.$(O): tokhash.c compiler.h config.h directiv.h hashtbl.h insns.h &
 insnsi.h nasm.h nasmlib.h opflags.h pptok.h preproc.h regs.h tokens.h
ver.$(O): ver.c compiler.h config.h directiv.h insnsi.h nasm.h nasmlib.h &
 opflags.h pptok.h preproc.h regs.h version.h
