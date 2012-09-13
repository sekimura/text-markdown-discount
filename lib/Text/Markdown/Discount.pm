package Text::Markdown::Discount;

use 5.008000;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Text::Markdown::XS ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
    markdown	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.03';

require XSLoader;
XSLoader::load('Text::Markdown::Discount', $VERSION);

sub new {
    return bless {}, 'Text::Markdown::Discount';
}

sub markdown {
    my ($self, $text) = @_;

    # Detect functional mode, and create an instance for this run..
    unless (ref $self) {
        if ( $self ne __PACKAGE__ ) {
            my $ob = __PACKAGE__->new();
                                # $self is text, $text is options
            return $ob->markdown($self, $text);
        }
        else {
            croak('Calling ' . $self . '->markdown (as a class method) is not supported.');
        }
    }
    return _markdown($text);
}


1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Text::Markdown::Discount - Perl extension interface for C<Discount>, an 
implementation of John Gruber's C<markdown> L<http://daringfireball.net/projects/markdown/> in C developed by David Loren Parsons L<http://www.pell.portland.or.us/~orc>.

=head1 SYNOPSIS

  use Text::Markdown::Discount;
  my $html = markdown($text)

=head1 DESCRIPTION

Given that the performance of Discount, Text::Markdown::Discount processes
markdown formatted text quickly and passes the Markdown test suite at
<http://daringfireball.net/projects/downloads/MarkdownTest_1.0.zip>

the interface of <markdown()> is not compatible with Text::Markdown::markdown() 

=head2 EXPORT

I<markdown> is exported by default.

=head1 SEE ALSO

L<Text::Markdown>, http://www.pell.portland.or.us/~orc/Code/markdown/

=head1 AUTHOR

Masayoshi Sekimura, E<lt>sekimura@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Masayoshi Sekimura

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

This product includes software developed by
David Loren Parsons <http://www.pell.portland.or.us/~orc>

=cut
