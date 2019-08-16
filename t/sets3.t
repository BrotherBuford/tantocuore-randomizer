## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use File::Basename qw(dirname);

use lib dirname(__FILE__) . '/../lib';
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(3);

my @testcases = (
    [
        [qw()],
        [qw(PR19 PR34)],
    ],
    [
        [qw(reminiscences=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(reminiscences=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(reminiscences=2 attack=1)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(reminiscences=1 attack=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2)],
        [qw(Error)],
    ],
    [
        [qw(reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(reminiscences=1 attack=2)],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );

