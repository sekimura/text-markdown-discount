use strict;
use warnings;
use utf8;
use Test::More tests => 2;
use Text::Markdown::Discount qw/markdown/;

my $html = '<article>abc</article>';
{
    is trim(markdown($html)), '<p><article>abc</article></p>';
}

Text::Markdown::Discount::with_html5_tags();

{
    my $md = Text::Markdown::Discount->new(html5 => 1);
    is trim(markdown($html)), '<article>abc</article>';
}

sub trim {
    my $text = shift;
    $text =~ s/\A\s+//ms;
    $text =~ s/\s+$//ms;
    $text;
}
