## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(101);

my @testcases = (
    [
        [qw()],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );
