#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

{
    package MyClass;
    sub new
    {
	my $class = shift;
	my $self;
	# Self-reference : this is a bug that we want to detect!
	$self = bless \$self, $class
    }
}


use Test::More tests => 1;
use Test::DiagRef;
