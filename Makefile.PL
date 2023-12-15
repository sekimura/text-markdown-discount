use strict;
use warnings;

use ExtUtils::MakeMaker;
use File::Spec;
use Config;

my $extdir = 'discount-2.2.7';
my $myextlib = File::Spec->catfile($extdir, 'libmarkdown.a');
my $clean_files = join (" ",
                  map{ File::Spec->catfile($extdir, $_) }
                  qw ( 

Csio.o
Makefile
basename.o
blocktags
branch
branch.o
cols
cols.o
config.cmd
config.h
config.log
config.mak
config.md
config.sed
config.sub
css.o
docheader.o
dumptree.o
echo
echo.o
emmatch.o
flags.o
generate.o
gethopt.o
github_flavoured.o
html5.o
libmarkdown
libmarkdown.a
librarian.sh
main.o
makepage
makepage.o
markdown
markdown.o
mkd2html
mkd2html.o
mkdio.h
mkdio.o
mktags
mktags.o
notspecial.o
pandoc_headers
pandoc_headers.o
pgm_options.o
resource.o
setup.o
tags.o
theme
theme.o
toc.o
version.c
version.o
xml.o
xmlpage.o

                  ));

sub MY::postamble {
    if ($^O eq 'MSWin32') {
        return mingw64_postamble();
    } else {
        return sprintf('
$(MYEXTLIB):
	%s
', qq{( cd $extdir; CC='cc -fPIC' sh configure.sh --with-fenced-code --with-dl=both; \$(MAKE) )\n});
    }
}

# This does not work for ActiveState Perl. But they have their own binary
# package of Text::Markdown::Discount.
sub mingw64_postamble {
    mingw64_config_vars();
    mingw64_copy_files();
    mingw64_expand_mkdio_h();

    return sprintf('
$(MYEXTLIB):
	%s
', qq{cd $extdir && \$(MAKE)\n});
}

sub mingw64_config_vars {
    my $config_vars_file = File::Spec->catfile($extdir, 'mingw64-config-vars.inc');
    open my $fh, '>', $config_vars_file
        or die "cannot create '$config_vars_file: $!";
    $fh->print(<<"EOF") or die "cannot write '$config_vars_file': $!";
CC = $Config{cc}
CFLAGS = $Config{ccflags} -fPIC
OPTIMIZE = $Config{optimize}
AR = ar
RANLIB = ranlib
EOF
    $fh->close or die "cannot close '$config_vars_file': $!";
}

sub mingw64_copy_files() {
    require File::Copy;
    my $mingw64_dir = 'mingw64';
    for my $file ('Makefile', 'config.h', 'blocktags', 'version.c') {
        my $src = File::Spec->catfile($mingw64_dir, $file);
        my $dest = File::Spec->catfile($extdir, $file);
        File::Copy::copy($src, $dest)
            or die "Cannot copy '$src' to '$dest': $!";
    }

}

sub mingw64_expand_mkdio_h {
    my $mkdio_h_in = File::Spec->catfile($extdir, 'mkdio.h.in');
    open my $in, '<', $mkdio_h_in
        or die "cannot open '$mkdio_h_in: $!";
    my $code = join '', <$in>;
    my %replace = (
        SCALAR_HEADER_INCLUDE => '#include <inttypes.h>',
        DWORD => 'uint32_t',
    );
    my $keys = join '|', keys %replace;
    $code =~ s/@($keys)@/$replace{$1}/g;
    my $mkdio_h = File::Spec->catfile($extdir, 'mkdio.h');
    open my $out, '>', $mkdio_h
        or die "cannot open '$mkdio_h' for writing: $!";
    $out->print($code) or die "cannot write '$mkdio_h': $!";
    $out->close or die "cannot close '$mkdio_h': $!";
}

WriteMakefile(
    NAME              => 'Text::Markdown::Discount',
    VERSION_FROM      => 'lib/Text/Markdown/Discount.pm',
    PREREQ_PM         => {},
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Text/Markdown/Discount.pm',
       AUTHOR         => 'Masayoshi Sekimura <sekimura@cpan.org>') : ()),
    LIBS               => '-L' . $extdir,
    INC               => '-I. -I' . $extdir,
    MYEXTLIB          => $myextlib,
    clean             => { FILES => $clean_files },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url  => 'https://github.com/sekimura/text-markdown-discount.git',
                web  => 'https://github.com/sekimura/text-markdown-discount',
            },
        },
    },
);
