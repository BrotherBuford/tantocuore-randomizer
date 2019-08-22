## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use File::Basename qw(dirname);

use lib dirname(__FILE__) . '/../lib';
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(5 101);

my @testcases = (
    [
        [qw()],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(events=1)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(buildings=1)],
        [qw(20-V PR14 PR19 PR34)],
    ],
    [
        [qw(events=1 buildings=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1)],
        [qw(20-V PR14 PR19 PR34)],
    ],
    [
        [qw(events=1 couples=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(buildings=1 couples=1)],
        [qw(20-V PR14 PR19 PR34)],
    ],
    [
        [qw(events=1 buildings=1 couples=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(events=1 attack=1)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(buildings=1 attack=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(events=1 buildings=1 attack=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 attack=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(events=1 couples=1 attack=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(buildings=1 couples=1 attack=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(events=1 buildings=1 couples=1 attack=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2)],
        [qw(Error)],
    ],
    [
        [qw(events=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(events=1 buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(couples=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(events=1 couples=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(buildings=1 couples=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(events=1 buildings=1 couples=1 attack=2)],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );

