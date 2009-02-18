use strict;
use warnings;

use ExtUtils::MakeMaker;
use File::Copy;
use File::Spec;
use Config;

my @c_files = qw(
    dumptree.c
    generate.c
    makepage.c
    markdown.c
    mkdio.c
    resource.c
    toc.c
    version.c
    xmlpage.c
);
my @h_files = qw(
    amalloc.h
    config.h
    cstring.h
    markdown.h
    mkdio.h
);

for my $f (@c_files, @h_files, ('configure.sh', 'configure.inc')) {
    my $src = File::Spec->catfile('../discount-1.3.1', $f);
    copy ($src, $f);
}
system('sh', 'configure.sh');

sub MY::postamble {
    return <<'MAKE_FRAG';
libdiscount_markdown$(LIB_EXT): $(O_FILES)
	$(AR) crv $@ $(O_FILES)
	$(RANLIB) $@
markdown$(OBJ_EXT): markdown.c config.h cstring.h markdown.h
generate$(OBJ_EXT): generate.c config.h cstring.h markdown.h
dumptree$(OBJ_EXT): dumptree.c cstring.h markdown.h
mkdio$(OBJ_EXT): mkdio.c mkdio.h cstring.h config.h
xmlpage$(OBJ_EXT): xmlpage.c mkdio.h cstring.h config.h
toc(OBJ_EXT): toc.c mkdio.h cstring.h config.h
MAKE_FRAG
}

## disable
sub MY::dynamic {}

WriteMakefile(
    NAME => 'libdiscount_markdown',
    INC => '-I.',
    clean => { FILES => 'config.* configure.* libdiscount_markdown.* *.c *.h *.so *.o'},
);
