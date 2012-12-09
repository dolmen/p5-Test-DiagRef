use strict;
use warnings;
package Test::DiagRef;
# ABSTRACT: detailed diagnostics for your reference tracking tests

use Exporter;
our @EXPORT_OK = 'diag_ref';

use Test::More ();

BEGIN {
    *diag = \&Test::More::diag;
}

use Exporter 'import';
our @EXPORT = 'diag_ref';

sub diag_ref ($)
{
    my $ref = shift;

    return unless defined $ref;

    unless (ref $ref) {
	diag 'value is a scalar';
	return
    }

    if (eval { require Devel::FindRef }) {
	diag Devel::FindRef::track($ref)
    } else {
	diag '(Install Devel::FindRef for a detailed report)'
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Test::DiagRef - Detailed diagnostics for your reference tracking tests

=head1 SYNOPSIS

    use Test::More tests => 1;
    use Test::DiagRef;
    use Scalar::Util 'weaken';

    my $obj = MyClass->new();

    weaken(my $ref = $obj);

    # Delete $obj
    undef $obj;

    is($ref, undef, 'no leak') or diag_ref;

=cut

# vim: set et sw=4 sts=4 :
