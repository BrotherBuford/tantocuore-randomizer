## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(2);

my @testcases = (
    [
        [qw()],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(private=1)],
        [qw()],
    ],
    [
        [qw(buildings=1)],
        [qw(27-II PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(attack=1)],
        [qw(20-II PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 attack=1)],
        [qw()],
    ],
    [
        [qw(buildings=1 attack=1)],
        [qw(Error)],
    ],
    [
        [qw(private=1 buildings=1 attack=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 buildings=1 attack=2)],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );
