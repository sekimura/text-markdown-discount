use strict;
use warnings;

use ExtUtils::MakeMaker;
use File::Spec;

my $extdir = 'discount-1.3.4';
my $myextlib = File::Spec->catfile($extdir, 'libmarkdown.a');
my $clean_files = join (" ",
                  map{ File::Spec->catfile($extdir, $_) }
                  qw ( 
                  markdwon mkd2html makepage theme libmarkdown.a
                  Csio.o
                  config.cmd
                  config.h
                  config.log
                  config.mak
                  config.md
                  config.sub
                  docheader.o
                  dumptree.o
                  generate.o
                  main.o
                  markdown
                  markdown.1
                  markdown.o
                  mkd2html.o
                  mkdio.o
                  resource.o
                  theme.o
                  toc.o
                  version.c
                  version.o
                  xmlpage.o
                  ));



sub MY::postamble {
    return sprintf('
$(MYEXTLIB):
	%s
', qq{( cd $extdir; sh configure.sh; make )\n});
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
);
