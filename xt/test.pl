#/usr/bin/perl

use ExtUtils::testlib;

use Text::Markdown 'markdown';
use Text::Markdown::XS;
use Benchmark;
use File::Slurp;
use Text::Diff;

my $text = read_file('index.text');
warn "XXXX";
my $a = Text::Markdown::XS::_markdown($text);
my $b = Text::Markdown::markdown($text);
$a .= "\n";

unless ( $a eq $b ) {
print diff \$a, \$b; 
#   die "BOO";
}
my $count = 1000;
timethese($count, {
    'Text::Markdown::XS' => sub { Text::Markdown::XS::_markdown($text) },
    'Text::Markdown' => sub { Text::Markdown::markdown($text) },
});


#warn Text::Markdown::markdown(<<EOF);
Text::Markdown::XS::_markdown(<<EOF);
* test
* Yup, test
EOF

