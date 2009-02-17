use strict;
use warnings;

use ExtUtils::MakeMaker;

sub MY::postamble {
    return <<'MAKE_FRAG';
$(MYEXTLIB):
	(cd ext; make libdiscount_markdown.$(DLEXT))
MAKE_FRAG
}

WriteMakefile(
    NAME              => 'Text::Markdown::Discount',
    VERSION_FROM      => 'lib/Text/Markdown/Discount.pm',
    PREREQ_PM         => {},
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Text/Markdown/Discount.pm',
       AUTHOR         => 'Masayoshi Sekimura <sekimura@cpan.org>') : ()),
    LIBS               => '-Lext',
    INC               => '-I. -Iext',
    MYEXTLIB          => 'ext/libdiscount_markdown.$(DLEXT)',
);
